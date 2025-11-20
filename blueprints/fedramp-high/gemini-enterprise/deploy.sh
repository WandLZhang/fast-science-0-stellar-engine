#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}   Welcome to the Gemini Enterprise FedRAMP High Blueprint  ${NC}"
echo -e "${GREEN}============================================================${NC}"
echo ""
# --- Main Menu ---
echo -e "${GREEN}Gemini Enterprise Deployment Helper${NC}"
echo "-----------------------------------"
echo "1. Deploy Stage 0 (Infrastructure & Prerequisites)"
echo "2. Deploy Stage 1 (Load Balancer & Access)"
echo "3. Exit"
read -p "Select an option [1-3]: " OPTION

if [[ "$OPTION" == "3" ]]; then
    exit 0
fi

# --- Discovery & Configuration (Common to both stages) ---

# Helper function to read values from terraform.tfvars
get_tfvar_value() {
    local file="$1"
    local key="$2"
    grep "^${key}\s*=" "$file" | head -n 1 | cut -d'=' -f2- | tr -d ' "'
}


# 0. Google Account Check
CURRENT_ACCOUNT=$(gcloud config get-value account 2>/dev/null)
echo -e "1. Current Google Account: ${YELLOW}${CURRENT_ACCOUNT}${NC}"
read -p "Is this the correct account? (y/N): " CONFIRM_ACCOUNT
if [[ "$CONFIRM_ACCOUNT" != "y" && "$CONFIRM_ACCOUNT" != "Y" ]]; then
    echo "Starting authentication flow..."
    gcloud auth login
    CURRENT_ACCOUNT=$(gcloud config get-value account 2>/dev/null)
    echo -e "Now authenticated as: ${YELLOW}${CURRENT_ACCOUNT}${NC}"
fi

# 0.5. ADC Check
echo -e "2. Checking Application Default Credentials (ADC)..."
if gcloud auth application-default print-access-token &>/dev/null; then
    echo -e "${GREEN}ADC is configured.${NC}"
    read -p "Do you want to keep using these credentials? (y/N): " CONFIRM_ADC
    if [[ "$CONFIRM_ADC" != "y" && "$CONFIRM_ADC" != "Y" ]]; then
        echo "Refreshing ADC..."
        gcloud auth application-default login
    fi
else
    echo -e "${YELLOW}Application Default Credentials not found.${NC}"
    read -p "Do you want to authenticate ADC now? (y/N): " DO_AUTH
    if [[ "$DO_AUTH" == "y" || "$DO_AUTH" == "Y" ]]; then
        gcloud auth application-default login
    else
        echo "Warning: Proceeding without ADC. Terraform might fail."
    fi
fi

# 0.75 Reuse Configuration Check (Before Project ID)
SKIP_PROMPTS=false
if [[ "$OPTION" == "1" && -f "gemini-stage-0/terraform.tfvars" ]]; then
    echo -e "${YELLOW}Found existing configuration in gemini-stage-0/terraform.tfvars.${NC}"
    read -p "Reuse existing configuration? (Y/n): " REUSE_CONFIG
    if [[ "$REUSE_CONFIG" != "n" && "$REUSE_CONFIG" != "N" ]]; then
        echo "Reading configuration from gemini-stage-0/terraform.tfvars..."
        SKIP_PROMPTS=true
        TFVARS_FILE="gemini-stage-0/terraform.tfvars"
        
        PROJECT_ID=$(get_tfvar_value "$TFVARS_FILE" "main_project_id")
        PREFIX=$(get_tfvar_value "$TFVARS_FILE" "prefix")
        REGION=$(get_tfvar_value "$TFVARS_FILE" "region")
        DOMAIN=$(get_tfvar_value "$TFVARS_FILE" "domain")
        DEPLOYMENT_TYPE=$(get_tfvar_value "$TFVARS_FILE" "deployment_type")
        ACCESS_POLICY_NUMBER=$(get_tfvar_value "$TFVARS_FILE" "access_policy_number")
        ADMIN_GROUP=$(get_tfvar_value "$TFVARS_FILE" "admin_group")
        USER_GROUP=$(get_tfvar_value "$TFVARS_FILE" "user_group")
        CREATE_DS_BOOL=$(get_tfvar_value "$TFVARS_FILE" "create_data_stores")
        ENABLE_CEP_BOOL=$(get_tfvar_value "$TFVARS_FILE" "enable_chrome_enterprise_premium")
        ACL_IDP_TYPE=$(get_tfvar_value "$TFVARS_FILE" "acl_idp_type")
        ACL_POOL_NAME=$(get_tfvar_value "$TFVARS_FILE" "acl_workforce_pool_name")
        
        echo -e "Using Project ID: ${YELLOW}${PROJECT_ID}${NC}"
        echo -e "Using Prefix: ${YELLOW}${PREFIX}${NC}"
        echo -e "Using Region: ${YELLOW}${REGION}${NC}"
        echo -e "Using Domain: ${YELLOW}${DOMAIN}${NC}"
    fi
elif [[ "$OPTION" == "2" && -f "gemini-stage-1/terraform.tfvars" ]]; then
    echo -e "${YELLOW}Found existing configuration in gemini-stage-1/terraform.tfvars.${NC}"
    read -p "Reuse existing configuration? (Y/n): " REUSE_CONFIG
    if [[ "$REUSE_CONFIG" != "n" && "$REUSE_CONFIG" != "N" ]]; then
        echo "Reading configuration from gemini-stage-1/terraform.tfvars..."
        SKIP_PROMPTS=true
        TFVARS_FILE="gemini-stage-1/terraform.tfvars"
        
        SSL_CERT_NAME=$(get_tfvar_value "$TFVARS_FILE" "ssl_certificate_name")
        GEMINI_CONFIG_ID=$(get_tfvar_value "$TFVARS_FILE" "gemini_config_id")
        GEMINI_DOMAIN=$(get_tfvar_value "$TFVARS_FILE" "gemini_enterprise_domain")
        STAGE_0_BUCKET=$(get_tfvar_value "$TFVARS_FILE" "stage_0_state_bucket")

        echo -e "Using SSL Certificate: ${YELLOW}${SSL_CERT_NAME}${NC}"
        echo -e "Using Gemini Config ID: ${YELLOW}${GEMINI_CONFIG_ID}${NC}"
        echo -e "Using Gemini Domain: ${YELLOW}${GEMINI_DOMAIN}${NC}"
        
        if [[ -n "$STAGE_0_BUCKET" ]]; then
            echo "Retrieving Project ID and Prefix from Stage 0 state in bucket: ${STAGE_0_BUCKET}..."
            STATE_CONTENT=$(gcloud storage cat "gs://${STAGE_0_BUCKET}/terraform/state/stage-0/default.tfstate" 2>/dev/null)
            
            if [[ -n "$STATE_CONTENT" ]]; then
                PROJECT_ID=$(echo "$STATE_CONTENT" | grep -A 5 '"main_project_id":' | grep '"value":' | head -n 1 | cut -d':' -f2 | tr -d ' ",')
                PREFIX=$(echo "$STATE_CONTENT" | grep -A 5 '"prefix":' | grep '"value":' | head -n 1 | cut -d':' -f2 | tr -d ' ",')
                
                echo -e "Retrieved Project ID: ${YELLOW}${PROJECT_ID}${NC}"
                echo -e "Retrieved Prefix: ${YELLOW}${PREFIX}${NC}"
            else
                echo -e "${RED}Warning: Could not read Stage 0 state file. You may need to enter Project ID and Prefix manually.${NC}"
            fi
        fi
    fi
fi

# 1. Project ID Check
if [[ -n "$PROJECT_ID" ]]; then
    # Project ID was reused from tfvars
    echo "Setting gcloud project to ${PROJECT_ID}..."
    gcloud config set project "${PROJECT_ID}"
else
    CURRENT_PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
    echo -e "3. Current Project ID: ${YELLOW}${CURRENT_PROJECT_ID}${NC}"
    read -p "Is this the correct Project ID for Gemini Enterprise? (y/N): " CONFIRM_PROJECT
    if [[ "$CONFIRM_PROJECT" != "y" && "$CONFIRM_PROJECT" != "Y" ]]; then
        read -p "Enter the Google Cloud Project ID: " PROJECT_ID
        echo "Setting gcloud project to ${PROJECT_ID}..."
        gcloud config set project "${PROJECT_ID}"
    else
        PROJECT_ID=$CURRENT_PROJECT_ID
    fi
fi

if [ -z "$PROJECT_ID" ]; then
    echo "Project ID is required."
    exit 1
fi
echo ""
echo -e "Using Gemini Enterprise Project ID: ${YELLOW}${PROJECT_ID}${NC}"

# Discover Org ID early for Domain discovery (Common)
ORG_ID=$(gcloud projects get-ancestors "${PROJECT_ID}" --format="value(id)" | tail -n 1)
echo -e "Found Organization ID: ${YELLOW}${ORG_ID}${NC}"

# 2. Prefix (Common - needed for Bucket Name)
if [[ -z "$PREFIX" ]]; then
    read -p "Enter Prefix (e.g., 'sedev'): " INPUT_PREFIX
    PREFIX=${INPUT_PREFIX:-"sedev"}
fi
echo -e "Using Prefix: ${YELLOW}${PREFIX}${NC}"

# 2.5 Geolocation (Hardcoded to 'us' for multi-region resources)
GEOLOCATION="us"




# --- Stage 0 Specific Prompts ---
if [[ "$OPTION" == "1" ]]; then



    if [[ "$SKIP_PROMPTS" == "false" ]]; then
        # 3. Region
        REGION=$(gcloud config get-value compute/region 2>/dev/null)
        if [ -z "$REGION" ]; then
            REGION="us-east4"
        fi
        read -p "Enter Region [${REGION}]: " INPUT_REGION
        REGION=${INPUT_REGION:-$REGION}
        echo -e "Using Region: ${YELLOW}${REGION}${NC}"

        # 4. Domain
        ORG_DOMAIN=$(gcloud organizations list --filter="name:organizations/${ORG_ID}" --format="value(displayName)" --format="value(displayName)" 2>/dev/null)

        if [ -n "$ORG_DOMAIN" ]; then
            DOMAIN="${ORG_DOMAIN}"
            echo -e "Using Organization Domain: ${YELLOW}${DOMAIN}${NC}"
        else
            read -p "Enter Domain (e.g., 'example.com'): " INPUT_DOMAIN
            DOMAIN=${INPUT_DOMAIN}
        fi
    fi

    if [[ "$SKIP_PROMPTS" == "false" ]]; then
        # 5. ACL Identity Provider Selection
        while true; do
        echo ""
        echo "Select ACL Identity Provider:"
        echo "----------------------------------------------------------------"
        echo "1) GSUITE (Default)"
        echo "   - Best for users with Google Workspace accounts."
        echo "   - Uses standard Google Groups (e.g., gcp-gemini-enterprise-admins@${DOMAIN})."
        echo "   - Simple setup, requires Cloud Identity or Google Workspace."
        echo ""
        echo "2) THIRD_PARTY (Workforce Identity Federation)"
        echo "   - Best for external identity providers (Okta, Azure AD, etc.)."
        echo "   - Syncless: No need to sync users to Google Cloud."
        echo "   - Uses Attribute-Based Access Control (ABAC)."
        echo "   - Requires a configured Workforce Identity Pool."
        echo "----------------------------------------------------------------"
        read -p "Enter selection (1 or 2): " ACL_SELECTION
        ACL_SELECTION=${ACL_SELECTION:-1}

        if [[ "$ACL_SELECTION" == "2" ]]; then
            echo "Fetching Workforce Identity Pools for Organization ${ORG_ID}..."
            POOLS=$(gcloud iam workforce-pools list --organization="${ORG_ID}" --location="global" --format="value(name)" 2>/dev/null)
            
            if [[ -z "$POOLS" ]]; then
                echo -e "${RED}No Workforce Identity Pools found in Organization ${ORG_ID}.${NC}"
                echo "Please select GSUITE or ensure you have a Workforce Pool configured."
                # Loop continues, allowing user to choose 1
            else
                echo "Available Workforce Pools:"
                IFS=$'\n' read -rd '' -a POOL_ARRAY <<< "$POOLS"
                for i in "${!POOL_ARRAY[@]}"; do
                    echo "$((i+1))) ${POOL_ARRAY[i]}"
                done
                
                read -p "Select a Workforce Pool (1-${#POOL_ARRAY[@]}): " POOL_INDEX
                if [[ "$POOL_INDEX" -ge 1 && "$POOL_INDEX" -le "${#POOL_ARRAY[@]}" ]]; then
                    SELECTED_POOL="${POOL_ARRAY[$((POOL_INDEX-1))]}"
                    ACL_IDP_TYPE="THIRD_PARTY"
                    ACL_POOL_NAME="${SELECTED_POOL}"
                    echo -e "ACL Identity Provider: ${GREEN}THIRD_PARTY (Pool: ${SELECTED_POOL})${NC}"
                    break
                else
                    echo -e "${RED}Invalid selection. Please try again.${NC}"
                fi
            fi
        else
            ACL_IDP_TYPE="GSUITE"
            ACL_POOL_NAME=""
            echo -e "ACL Identity Provider: ${GREEN}GSUITE${NC}"
            echo ""
            break
        fi
        done
    fi

    # 4.1 Admin & User Groups
    if [[ "$SKIP_PROMPTS" == "false" ]]; then
        if [[ "$ACL_IDP_TYPE" == "GSUITE" ]]; then
            DEFAULT_ADMIN_GROUP="gcp-gemini-enterprise-admins@${DOMAIN}"
            DEFAULT_USER_GROUP="gcp-gemini-enterprise-users@${DOMAIN}"
            
            echo "Press Enter to accept the default values for Admin and User Groups."
            read -p "Enter Admin Group Email [${DEFAULT_ADMIN_GROUP}]: " INPUT_ADMIN_GROUP
            ADMIN_GROUP=${INPUT_ADMIN_GROUP:-$DEFAULT_ADMIN_GROUP}
            # Add group: prefix if not present and looks like an email
            if [[ "$ADMIN_GROUP" != *":"* ]]; then
                ADMIN_GROUP="group:${ADMIN_GROUP}"
            fi
            echo -e "Using Admin Group: ${YELLOW}${ADMIN_GROUP}${NC}"

            read -p "Enter User Group Email [${DEFAULT_USER_GROUP}]: " INPUT_USER_GROUP
            USER_GROUP=${INPUT_USER_GROUP:-$DEFAULT_USER_GROUP}
            # Add group: prefix if not present and looks like an email
            if [[ "$USER_GROUP" != *":"* ]]; then
                USER_GROUP="group:${USER_GROUP}"
            fi
            echo -e "Using User Group: ${YELLOW}${USER_GROUP}${NC}"

        else
            # THIRD_PARTY (Workforce Identity)
            echo -e "${YELLOW}For Workforce Identity, please enter the full Principal Set.${NC}"
            echo "This allows you to map groups or attributes from your IdP to IAM roles."
            echo ""
            echo "Examples:"
            echo " - All users in a specific IdP group:"
            echo "   principalSet://iam.googleapis.com/locations/global/workforcePools/${ACL_POOL_NAME}/group/GROUP_ID"
            echo ""
            echo " - All users with a specific attribute (e.g., department=engineering):"
            echo "   principalSet://iam.googleapis.com/locations/global/workforcePools/${ACL_POOL_NAME}/attribute.department/engineering"
            echo ""
            echo " - All users in the pool (Use with caution):"
            echo "   principalSet://iam.googleapis.com/locations/global/workforcePools/${ACL_POOL_NAME}/*"
            echo ""
            
            read -p "Enter Admin Principal Set: " ADMIN_GROUP
            while [[ -z "$ADMIN_GROUP" ]]; do
                echo "Admin Principal Set cannot be empty."
                read -p "Enter Admin Principal Set: " ADMIN_GROUP
            done
            echo -e "Using Admin Principal: ${YELLOW}${ADMIN_GROUP}${NC}"

            read -p "Enter User Principal Set: " USER_GROUP
            while [[ -z "$USER_GROUP" ]]; do
                echo "User Principal Set cannot be empty."
                read -p "Enter User Principal Set: " USER_GROUP
            done
            echo -e "Using User Principal: ${YELLOW}${USER_GROUP}${NC}"
        fi

        # 5. Access Policy Number (Common)
        echo "Discovering Access Policy..."
        ACCESS_POLICY_NUMBER=$(gcloud access-context-manager policies list --organization "${ORG_ID}" --format="value(name)" --quiet 2>/dev/null | head -n 1)
        if [ -z "$ACCESS_POLICY_NUMBER" ]; then
            echo -e "${YELLOW}Warning: Could not auto-discover Access Policy Number.${NC}"
            read -p "Enter Access Policy Number: " ACCESS_POLICY_NUMBER
        else
            ACCESS_POLICY_NUMBER=$(basename "${ACCESS_POLICY_NUMBER}")
            echo -e "Found Access Policy Number: ${YELLOW}${ACCESS_POLICY_NUMBER}${NC}"
        fi
        echo ""

        # 5. Deployment Type
        echo -e "Select Deployment Type:"
        echo -e "1) Regional External Application Load Balancer"
        echo -e "2) Regional Internal Application Load Balancer"
        read -p "Enter choice [1]: " DEPLOY_CHOICE
        DEPLOY_CHOICE=${DEPLOY_CHOICE:-1}

        if [[ "$DEPLOY_CHOICE" == "2" ]]; then
            DEPLOYMENT_TYPE="internal"
        else
            DEPLOYMENT_TYPE="external"
        fi
        echo ""
        echo -e "Using Deployment Type: ${YELLOW}${DEPLOYMENT_TYPE}${NC}"
    fi
fi

# If Stage 1 is selected, we still need REGION and DOMAIN, but they are not prompted.
# For Stage 1, these values are read from the state file.
# So, we only need to echo them if they were set in Stage 0.
if [[ "$OPTION" == "1" ]]; then
    echo -e "Using Domain: ${YELLOW}${DOMAIN}${NC}"
    echo -e "Using Region: ${YELLOW}${REGION}${NC}"
fi


# --- Bucket Setup (Common) ---

BUCKET_NAME="${PREFIX}-gemini-enterprise-tf-state-${PROJECT_ID}"

echo -e "Checking for Terraform State Bucket: ${YELLOW}${BUCKET_NAME}${NC}"

# --- CMEK Variables ---
KEYRING_NAME="${PREFIX}-gemini-keyring"
KEY_NAME="${PREFIX}-gemini-key"
KEY_LOCATION="${GEOLOCATION}"
KEY_ID="projects/${PROJECT_ID}/locations/${KEY_LOCATION}/keyRings/${KEYRING_NAME}/cryptoKeys/${KEY_NAME}"

# --- Stage 0 ---

if [[ "$OPTION" == "1" ]]; then
    echo -e "${BLUE}--- Starting Stage 0 Deployment ---${NC}"

    # --- Enable Required APIs (Unconditional) ---
    echo "Enabling Cloud KMS and Storage APIs..."
    if ! gcloud services enable cloudkms.googleapis.com storage.googleapis.com --project "${PROJECT_ID}"; then
        echo -e "${RED}Error: Failed to enable required APIs. Check your permissions.${NC}"
        exit 1
    fi

    # --- Ensure App CMEK Key Exists (Unconditional) ---
    # This key is used for:
    # 1. Terraform State Bucket (via default-encryption-key)
    # 2. BigQuery Datasets (via Terraform)
    # 3. Discovery Engine Data Stores (via Terraform)
    # It must exist in GEOLOCATION (us) to support multi-region resources.

    echo -e "Checking for CMEK Key in ${GEOLOCATION}..."
    KEY_LOCATION="${GEOLOCATION}"
    KEY_ID="projects/${PROJECT_ID}/locations/${KEY_LOCATION}/keyRings/${KEYRING_NAME}/cryptoKeys/${KEY_NAME}"

    # Check if the bucket already exists and has a default KMS key
    EXISTING_BUCKET_KEY=$(gcloud storage buckets describe "gs://${BUCKET_NAME}" --format="value(encryption.defaultKmsKeyName)" 2>/dev/null || true)

    if [[ -n "$EXISTING_BUCKET_KEY" ]]; then
        echo -e "${YELLOW}Detected existing CMEK key on bucket: ${EXISTING_BUCKET_KEY}${NC}"
        KEY_ID="${EXISTING_BUCKET_KEY}"
        
        # Parse components from the existing key ID
        # Format: projects/PROJECT/locations/LOCATION/keyRings/KEYRING/cryptoKeys/KEY
        KEY_LOCATION=$(echo "$KEY_ID" | cut -d'/' -f4)
        KEYRING_NAME=$(echo "$KEY_ID" | cut -d'/' -f6)
        KEY_NAME=$(echo "$KEY_ID" | cut -d'/' -f8)
        
        echo -e "Using detected Key Location: ${YELLOW}${KEY_LOCATION}${NC}"
        echo -e "Using detected Key Ring: ${YELLOW}${KEYRING_NAME}${NC}"
        echo -e "Using detected Key Name: ${YELLOW}${KEY_NAME}${NC}"
    fi

    # 1. Ensure KeyRing exists in GEOLOCATION
    if ! gcloud kms keyrings describe "${KEYRING_NAME}" --location "${GEOLOCATION}" --project "${PROJECT_ID}" &>/dev/null; then
        echo "Creating Key Ring: ${KEYRING_NAME} in ${GEOLOCATION}..."
        if ! gcloud kms keyrings create "${KEYRING_NAME}" \
            --location "${GEOLOCATION}" \
            --project "${PROJECT_ID}"; then
            echo -e "${RED}Error: Failed to create Key Ring.${NC}"
            exit 1
        fi
    else
        # echo "Key Ring ${KEYRING_NAME} in ${GEOLOCATION} already exists."
        true
    fi

    # 2. Ensure Key exists in GEOLOCATION
    if ! gcloud kms keys describe "${KEY_NAME}" --keyring "${KEYRING_NAME}" --location "${KEY_LOCATION}" --project "${PROJECT_ID}" &>/dev/null; then
        echo "Creating Key ${KEY_NAME} in ${GEOLOCATION}..."
        if ! gcloud kms keys create "${KEY_NAME}" \
            --keyring "${KEYRING_NAME}" \
            --location "${KEY_LOCATION}" \
            --purpose "encryption" \
            --protection-level "hsm" \
            --project "${PROJECT_ID}" \
            --rotation-period "7776000s" \
            --next-rotation-time "$(date -u -d '+90 days' +%Y-%m-%dT%H:%M:%SZ)"; then
            echo -e "${RED}Error: Failed to create KMS Key.${NC}"
            exit 1
        fi
    else
        # echo "Key ${KEY_NAME} in ${GEOLOCATION} already exists."
        true
    fi

    # 3. Grant IAM permissions (Idempotent)
    STORAGE_SERVICE_AGENT=$(gcloud storage service-agent --project="${PROJECT_ID}")
    # 3. Grant Current User Encrypter/Decrypter role on the key (Required for GCS access)
    CURRENT_USER=$(gcloud config get-value account 2>/dev/null)
    echo "Granting KMS Encrypter/Decrypter role to ${CURRENT_USER}..."
    if ! gcloud kms keys add-iam-policy-binding "${KEY_NAME}" \
        --keyring "${KEYRING_NAME}" \
        --location "${KEY_LOCATION}" \
        --project "${PROJECT_ID}" \
        --member "user:${CURRENT_USER}" \
        --role "roles/cloudkms.cryptoKeyEncrypterDecrypter" >/dev/null; then
        echo -e "${RED}Error: Failed to grant IAM role to current user.${NC}"
        exit 1
    fi

    # 4. Grant Storage Service Agent Encrypter/Decrypter role (Bootstrapping)
    # Using authorize-cmek is the recommended way to ensure the service agent has access.
    echo "Authorizing Storage Service Agent for CMEK..."
    if ! gcloud storage service-agent \
        --project="${PROJECT_ID}" \
        --authorize-cmek="${KEY_ID}" >/dev/null; then
        echo -e "${RED}Error: Failed to authorize Storage Service Agent.${NC}"
        exit 1
    fi

    # BQ and Discovery Engine grants removed from here to reduce noise.
    # They are handled by Terraform in discovery-engine.tf.

    if ! gcloud storage buckets describe "gs://${BUCKET_NAME}" --project "${PROJECT_ID}" &>/dev/null; then
        echo "Bucket does not exist. Creating..."
        # Create Bucket with CMEK (using the key we just ensured exists)
        # Bucket location must match the Key location (GEOLOCATION = us)
        if ! gcloud storage buckets create "gs://${BUCKET_NAME}" --project "${PROJECT_ID}" --location "${GEOLOCATION}" --uniform-bucket-level-access --default-encryption-key "${KEY_ID}"; then
            echo -e "${RED}Error: Failed to create bucket.${NC}"
            exit 1
        fi
        echo -e "${GREEN}Bucket created.${NC}"
    else
        echo -e "${GREEN}Bucket already exists.${NC}"
    fi

    # Automated Org Policy Check for External Deployment
    if [[ "$DEPLOYMENT_TYPE" == "external" ]]; then
        echo "Verifying Organization Policy for External Load Balancer..."
        POLICY_JSON=$(gcloud org-policies describe compute.restrictLoadBalancerCreationForTypes --project="${PROJECT_ID}" --effective --format="json" 2>/dev/null || true)
        
        if [ -n "$POLICY_JSON" ]; then
            # Check allowedValues (allowlist)
            if echo "$POLICY_JSON" | grep -q "allowedValues"; then
                if ! echo "$POLICY_JSON" | grep -q "EXTERNAL_MANAGED_HTTP_HTTPS"; then
                     echo -e "${RED}CRITICAL WARNING: Organization Policy 'compute.restrictLoadBalancerCreationForTypes' does not allow 'EXTERNAL_MANAGED_HTTP_HTTPS'.${NC}"
                     echo "You do not currently have this org policy allowing this."
                     echo "Please fix the org policy first, then re-run the script for the Regional External Application Load Balancer deployment to work."
                     exit 1
                fi
            fi
            
            # Check deniedValues (denylist)
             if echo "$POLICY_JSON" | grep -q "deniedValues"; then
                 if echo "$POLICY_JSON" | grep -q "EXTERNAL_MANAGED_HTTP_HTTPS"; then
                     echo -e "${RED}CRITICAL WARNING: Organization Policy 'compute.restrictLoadBalancerCreationForTypes' explicitly denies 'EXTERNAL_MANAGED_HTTP_HTTPS'.${NC}"
                     echo "You do not currently have this org policy allowing this."
                     echo "Please fix the org policy first, then re-run the script for the Regional External Application Load Balancer deployment to work."
                     exit 1
                 fi
            fi
            
            echo -e "${GREEN}No restriction on EXTERNAL_MANAGED_HTTP_HTTPS load balancers found.${NC}"
        else
            echo -e "${YELLOW}Could not verify Organization Policy. You may not have the required IAM permissions to view it.${NC}"
            echo "Please verify manually that 'compute.restrictLoadBalancerCreationForTypes' allows 'EXTERNAL_MANAGED_HTTP_HTTPS'."
        fi
    fi
    
    echo -e "${YELLOW}IMPORTANT: Before proceeding, ensure you have completed the following manual prerequisites:${NC}"
    echo "1. Organization Policy: 'compute.restrictLoadBalancerCreationForTypes' allows 'EXTERNAL_MANAGED_HTTP_HTTPS' (if External)."
    echo "2. OAuth Consent Screen: Configured as Internal."
    echo "3. Google Workspace Groups: Created admin/user groups (${ADMIN_GROUP}, ${USER_GROUP})."

    echo ""
    read -p "Have you completed these steps? (y/N): " CONFIRM_PRE
    if [[ "$CONFIRM_PRE" != "y" && "$CONFIRM_PRE" != "Y" ]]; then
        echo "Please complete the prerequisites and try again."
        exit 1
    fi

    # 6. Chrome Enterprise Premium (Zero Trust)
    if [[ "$SKIP_PROMPTS" == "false" ]]; then
        read -p "Use Chrome Enterprise Premium's Endpoint Security? (Requires subscription) (y/N): " CEP_CHOICE
    if [[ "$CEP_CHOICE" == "y" || "$CEP_CHOICE" == "Y" ]]; then
        ENABLE_CEP_BOOL="true"
    else
        ENABLE_CEP_BOOL="false"
    fi
        echo -e "Enable Zero Trust: ${YELLOW}${ENABLE_CEP_BOOL}${NC}"
        echo ""

        # 7. Data Stores (Discovery Engine)
        read -p "Create Data Stores for Gemini Enterprise? (Y/n): " DS_CHOICE
        if [[ "$DS_CHOICE" == "n" || "$DS_CHOICE" == "N" ]]; then
            CREATE_DS_BOOL="false"
        else
            CREATE_DS_BOOL="true"
        fi
        echo -e "Create Data Stores: ${YELLOW}${CREATE_DS_BOOL}${NC}"
        echo ""
    fi
    # ACL Identity Provider selection moved to Step 4

    # Organization ID & Access Policy (Already discovered)
    # ORG_ID already discovered above
    # ACCESS_POLICY_NUMBER already discovered above

    cd gemini-stage-0

    # Generate terraform.tfvars
    if [[ "$SKIP_PROMPTS" == "false" ]]; then
        cat > terraform.tfvars <<EOF
deployment_type = "${DEPLOYMENT_TYPE}"
domain = "${DOMAIN}"
main_project_id = "${PROJECT_ID}"
prefix = "${PREFIX}"
region = "${REGION}"
geolocation = "us"
admin_group = "${ADMIN_GROUP}"
user_group = "${USER_GROUP}"
access_policy_number = ${ACCESS_POLICY_NUMBER}
create_data_stores = ${CREATE_DS_BOOL}
acl_idp_type = "${ACL_IDP_TYPE}"
acl_workforce_pool_name = "${ACL_POOL_NAME}"
kms_key_id = "${KEY_ID}"
enable_chrome_enterprise_premium = ${ENABLE_CEP_BOOL}

# Example Data Stores
gcs_data_store_names = ["company-docs", "knowledge-base", "team-playbooks"]
bq_data_store_configs = [
  {
    dataset_id = "internal_wiki"
    table_id   = "articles_v2"
  },
  {
    dataset_id = "product_data"
    table_id   = "specs_latest"
  },
  {
    dataset_id = "support_tickets"
    table_id   = "resolved_issues"
  }
]
EOF
        echo "Generated gemini-stage-0/terraform.tfvars"
    else
        echo "Using existing gemini-stage-0/terraform.tfvars"
    fi

    # Initialize Terraform
    echo "Initializing Terraform (Stage 0)..."
    terraform init -migrate-state -backend-config="bucket=${BUCKET_NAME}" -backend-config="prefix=terraform/state/stage-0"

    # Apply Terraform
    echo ""
    echo "Applying Terraform (Stage 0)..."
    terraform apply -auto-approve

    echo -e "${GREEN}Stage 0 Complete!${NC}"
    echo ""
    echo -e "${YELLOW}IMPORTANT NEXT STEPS:${NC}"
    echo -e "1. Run the ${BLUE}Gem4Gov CLI${NC} to configure your Gemini Enterprise instance."
    echo "   - This will provide you with the 'Gemini Config ID'."
    echo -e "2. Point the ${BLUE}gemini_enterprise_ip${NC} to the DNS A record on the subdomain you would like to host the app on."
    echo -e "3. Provision an SSL Certificate and upload it to Google Cloud into Certificate Manager."
    echo -e "4. Update ${BLUE}gemini-stage-1/terraform.tfvars${NC} with these values."
    echo -e "5. Run this script again and select ${BLUE}Option 2 (Deploy Stage 1)${NC}."
    exit 0
fi

if [[ "$OPTION" == "2" ]]; then
    echo ""
    echo "----------------------------------------------------------------"
    echo "Stage 1 Configuration (Load Balancer & DNS)"
    echo "----------------------------------------------------------------"

    # Check if Stage 0 state exists
    echo "Checking for Stage 0 state file..."
    if ! gcloud storage ls "gs://${BUCKET_NAME}/terraform/state/stage-0/default.tfstate"; then
        echo -e "${RED}Error: Stage 0 state file not found in gs://${BUCKET_NAME}/terraform/state/stage-0/${NC}"
        echo "Please run Stage 0 first."
        exit 1
    fi



    # Attempt to discover Google Org Domain from Stage 0 remote state
    if [[ -z "$DOMAIN" ]]; then
        STATE_CONTENT=$(gcloud storage cat "gs://${BUCKET_NAME}/terraform/state/stage-0/default.tfstate" 2>/dev/null)
        if [[ -n "$STATE_CONTENT" ]]; then
            # Extract domain from outputs.domain.value
            DOMAIN=$(echo "$STATE_CONTENT" | grep -A 5 '"domain":' | grep '"value":' | head -n 1 | cut -d':' -f2 | tr -d ' ",')
        fi
    fi

    if [[ "$SKIP_PROMPTS" == "false" ]]; then
        # Prompt for SSL Certificate Name (Default to gemini-enterprise-cert)
        DEFAULT_SSL_CERT="gemini-enterprise-cert"
        read -p "Enter the name of your pre-uploaded SSL Certificate in Google Cloud [${DEFAULT_SSL_CERT}]: " SSL_CERT_NAME
        SSL_CERT_NAME=${SSL_CERT_NAME:-$DEFAULT_SSL_CERT}

        # Prompt for Gemini Config ID
        echo ""
        echo "Please run the Gem4Gov CLI tool now if you haven't already."
        echo "The CLI will output a Gemini Config ID."
        while [[ -z "$GEMINI_CONFIG_ID" ]]; do
            read -p "Enter your Gemini Config ID: " GEMINI_CONFIG_ID
        done

        # Prompt for Gemini Enterprise Domain
        echo ""
        DEFAULT_GEMINI_DOMAIN="gemini.${DOMAIN}"
        read -p "Enter your Gemini Enterprise Domain [${DEFAULT_GEMINI_DOMAIN}]: " GEMINI_DOMAIN
        GEMINI_DOMAIN=${GEMINI_DOMAIN:-$DEFAULT_GEMINI_DOMAIN}
        echo "Using Gemini Domain: ${GEMINI_DOMAIN}"
    fi

    # Enter Stage 1 directory
    cd gemini-stage-1

    # Remove legacy backend.tf if it exists
    rm -f backend.tf

    # Generate terraform.tfvars for Stage 1
    if [[ "$SKIP_PROMPTS" == "false" ]]; then
        cat > terraform.tfvars <<EOF
stage_0_state_bucket = "${BUCKET_NAME}"
gemini_enterprise_domain = "${GEMINI_DOMAIN}"
ssl_certificate_name = "${SSL_CERT_NAME}"
gemini_config_id = "${GEMINI_CONFIG_ID}"
EOF
        echo "Generated gemini-stage-1/terraform.tfvars"
    else
        echo "Using existing gemini-stage-1/terraform.tfvars"
    fi

    # Initialize Terraform
    echo "Initializing Terraform (Stage 1)..."
    terraform init -migrate-state -backend-config="bucket=${BUCKET_NAME}" -backend-config="prefix=terraform/state/stage-1"

    # Apply Terraform
    echo ""
    echo "Applying Terraform (Stage 1)..."
    terraform apply -var-file="terraform.tfvars" -auto-approve

    echo -e "${GREEN}Stage 1 Complete!${NC}"
    exit 0
fi


