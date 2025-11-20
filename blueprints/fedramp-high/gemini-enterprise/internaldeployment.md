# Gemini Enterprise on GCP - FedRAMP High (Internal Load Balancer Deployment)

This document outlines the deployment of the Gemini Enterprise application on Google Cloud Platform, specifically for **internal-only access** from on-premise networks or other VPCs connected via Cloud VPN or Interconnect. This guide uses the main `gemini-stage-0` and `gemini-stage-1` directories, with specific variable settings.

## Deployment Overview

This deployment uses a Regional *Internal* HTTP(S) Load Balancer (ILB) by setting `deployment_type = "internal"` in the `terraform.tfvars` files for both stages. The application will NOT be accessible from the public internet.

**Key Components:**

*   **VPC & Subnet:** Defined in `gemini-stage-0/network.tf`. The subnet range for the ILB can be set via `internal_lb_subnet_range` in `gemini-stage-0/terraform.tfvars`.
*   **KMS Keys:** Defined in `gemini-stage-0/discovery-engine.tf`.
*   **Discovery Engine:** Configured in `gemini-stage-0/discovery-engine.tf`.
*   **Internal Load Balancer:** Configured in `gemini-stage-1/load_balancer.tf`, enabled by `deployment_type = "internal"`.
*   **IAP:** Identity-Aware Proxy is used to secure access to the ILB.

## Prerequisites

1.  **Network Connectivity:** Ensure your on-premise network has a working connection to the GCP VPC where Gemini Enterprise will be deployed. This must be one of:
    *   [Cloud VPN](https://cloud.google.com/network-connectivity/docs/vpn)
    *   [Cloud Interconnect](https://cloud.google.com/network-connectivity/docs/interconnect)

2.  **Internal DNS Server:** You must have an internal DNS server (e.g., Windows DNS, BIND) on your on-premise network that your clients use for name resolution.

3.  **IP Address Space:** Ensure the VPC's IP range (defined by `internal_lb_subnet_range` in `gemini-stage-0/variables.tf`) does not conflict with your on-premise network ranges. See [Handling Overlapping IP Ranges](#handling-overlapping-ip-ranges).

4.  **Permissions:** Ensure the service account or user running Terraform has the necessary permissions to create all resources defined in `gemini-stage-0` and `gemini-stage-1`.

5.  **Organization Policy:** If deploying the **External** variant (not the primary focus of this doc, but relevant if reusing this blueprint), you must ensure the `compute.restrictLoadBalancerCreationForTypes` organization policy allows `EXTERNAL_MANAGED_HTTP_HTTPS` load balancers.

## Deployment Steps

1.  **Configure Stage 0:**
    *   Navigate to `blueprints/fedramp-high/gemini-enterprise/gemini-stage-0/`.
    *   Create a `terraform.tfvars` file.
    *   **Crucially, set `deployment_type = "internal"`**.
    *   Optionally, set `internal_lb_subnet_range` to a non-conflicting CIDR block.
    *   Fill in other required variables.

2.  **Deploy Stage 0:**
    *   Initialize Terraform: `terraform init`
    *   Review the plan: `terraform plan`
    *   Apply the configuration: `terraform apply`
    This will set up the network, KMS, and Discovery Engine.

3.  **Provision Gemini Enterprise:**
    *   Run the `gem4gov` CLI tool according to its documentation to provision the Gemini Enterprise application instance. This tool will likely require outputs from Stage 0 and will provide a `gemini_config_id` or similar identifier.

4.  **Configure Stage 1:**
    *   Navigate to `blueprints/fedramp-high/gemini-enterprise/gemini-stage-1/`.
    *   Create a `terraform.tfvars` file.
    *   **Crucially, set `deployment_type = "internal"`** (must match Stage 0).
    *   Update other necessary variables (e.g., `gemini_config_id` from the previous step, `ssl_certificate_name`).

5.  **Deploy Stage 1:**
    *   Initialize Terraform: `terraform init`
    *   Review the plan: `terraform plan`
    *   Apply the configuration: `terraform apply`
    This will set up the Internal Load Balancer, IAP, and associated resources.

6.  **Note Internal IP:** Record the internal IP address assigned to the ILB from the Terraform output of Stage 0 (`gemini_enterprise_ip`).

7.  **Configure Internal DNS:** Follow the steps in [DNS Configuration (Split-Horizon DNS)](#dns-configuration-split-horizon-dns).

8.  **Obtain and Configure SSL Certificate:** Follow [SSL Certificate Provisioning for HTTPS](#ssl-certificate-provisioning-for-https).

## DNS Configuration (Split-Horizon DNS)

The goal is to configure your internal, on-premise DNS to resolve the domain name to the private IP address of the Google Cloud Internal Load Balancer.

**Core Concept:**

*   **Public DNS:** Used by the internet.
*   **Private DNS:** Used within your corporate network for internal resources.

You need to make your on-premise DNS server authoritative for resolving the internal service name (e.g., `gemini-internal.mycompany.com`) to the reserved internal IP in GCP (e.g., `10.10.10.5`).

**Steps:**

1.  **Identify Your Internal DNS Server:** Locate your corporate DNS server (e.g., Windows DNS, BIND).
2.  **Create a DNS 'A' Record:** On the internal DNS server, create a new 'A' record.
3.  **Configure the 'A' Record:**
    *   **Name/Host:** The desired subdomain (e.g., `gemini-internal`).
    *   **IP Address:** The reserved internal IP of the GCP load balancer (from Stage 0 output).
    *   Example: `gemini-internal.mycompany.com -> 10.10.10.5`
4.  **Test from On-Premise:** Use `nslookup` or `ping` from an on-premise machine to verify resolution to the internal IP.
    ```bash
    ping gemini-internal.mycompany.com
    ```
    Flush DNS cache if needed (`ipconfig /flushdns` on Windows).

## SSL Certificate Provisioning for HTTPS

To enable HTTPS on the internal load balancer, an SSL certificate signed by your organization's internal Certificate Authority (CA) is required.

**Process:**

1.  **Private Key:** Secret file used by the load balancer for encryption.
2.  **Certificate Signing Request (CSR):** File generated from the private key, submitted to the internal CA.
3.  **Signed Certificate:** File provided by the internal CA after signing the CSR.

**Customer Action Plan:**

1.  **Generate the Private Key:** On a secure workstation, use OpenSSL:
    ```bash
    openssl genrsa -out gemini-internal.key 2048
    ```
    **Warning:** Protect `gemini-internal.key` as it is highly sensitive.

2.  **Create the Certificate Signing Request (CSR):**
    ```bash
    openssl req -new -key gemini-internal.key -out gemini-internal.csr
    ```
    Provide the requested information. The **Common Name** MUST match the internal domain name users will access (e.g., `gemini-internal.mycompany.gov`).

    | Field                      | Example Value                     | Description                                                                 |
    | :------------------------- | :-------------------------------- | :-------------------------------------------------------------------------- |
    | Country Name (2 letter code) | US                                | Your country code.                                                          |
    | State or Province Name     | Virginia                          | Your state or province.                                                     |
    | Locality Name (eg, city)   | Reston                            | Your city.                                                                  |
    | Organization Name          | Department of Example             | Your official organization name.                                            |
    | Organizational Unit Name   | IT Security                       | Your specific department or unit.                                           |
    | Common Name (e.g. server FQDN) | gemini-internal.mycompany.gov     | **Crucial:** Exact internal domain name for access.                         |
    | Email Address              | your-email@mycompany.gov          | An administrative contact email.                                            |

3.  **Get the CSR Signed by Your Internal CA:** Submit `gemini-internal.csr` to your internal IT/Cybersecurity team for signature. They will return:
    *   The Signed Certificate (e.g., `gemini-internal.crt`).
    *   Intermediate/Chain Certificate (if applicable, e.g., `ca-chain.crt`).

4.  **Securely Provide Certificate Files to GCP Admin:** Transfer the following files securely to the administrator managing the GCP deployment:
    *   `gemini-internal.key`
    *   `gemini-internal.crt`
    *   Intermediate/Chain Certificate (if provided).

5.  **Upload to GCP Certificate Manager:** The GCP administrator will upload these certificate files to Google Cloud Certificate Manager.

6.  **Update Load Balancer:** The Terraform configuration in `gemini-stage-1/load_balancer.tf` must be updated to reference the uploaded certificate in Certificate Manager, and `terraform apply` run again if needed.

7.  **Verification (Recommended):** After the certificate is deployed, verify from an on-premise machine:
    ```bash
    openssl s_client -connect <LOAD_BALANCER_INTERNAL_IP>:443 -servername <YOUR_INTERNAL_DOMAIN>
    ```
    Example:
    ```bash
    openssl s_client -connect 10.10.10.5:443 -servername gemini-internal.mycompany.gov
    ```
    Look for `Verify return code: 0 (ok)` and check that the certificate details match.

## Access Flow

1.  User on on-premise network opens `https://gemini-internal.mycompany.com`.
2.  Client queries the *internal* DNS server.
3.  Internal DNS server responds with the ILB's private IP (e.g., `10.10.10.5`).
4.  Traffic is routed over the Cloud VPN/Interconnect to the GCP VPC.
5.  The ILB receives the request, IAP enforces access, and the request is forwarded to the Gemini Enterprise application.

## Handling Overlapping IP Ranges

**Note on IP Addressing:** The most straightforward way to ensure connectivity between your on-premise network and GCP is to use non-overlapping IP address ranges. The solutions below are for scenarios where re-addressing your GCP VPC or on-premise network is not feasible. Planning unique IP space allocation upfront is highly recommended to avoid this complexity.

Creating a new Google Cloud VPC with a conflicting (overlapping) internal IP address of an on-prem range is a major networking challenge that requires careful planning to resolve.
You cannot directly connect two networks that have the same or overlapping CIDR blocks via VPC Network Peering, Cloud VPN, or Cloud Interconnect.

Here are the standard architectural solutions to this problem:

**Solution 1: Re-IP the New VPC (The Best Practice)**
This is the cleanest and most architecturally sound solution.
*   **How it Works:** Recreate the new VPC with a unique, non-overlapping IP address range before deploying significant resources.
*   **Pros:** Eliminates all routing ambiguity, simplifies networking and security rules.
*   **Cons:** Can be extremely disruptive if resources are already deployed.
*   **Best For:** Greenfield deployments. Proactive IP Address Management (IPAM) is crucial.

**Solution 2: Use Network Address Translation (NAT) (The Standard Workaround)**
This is the most common solution when re-IPing is not an option.
*   **How it Works:**
    1.  **Create a Hub/Transit VPC:** Set up a third VPC with a unique IP range (e.g., `10.255.255.0/24`) that does NOT overlap with the on-prem network.
    2.  **Deploy a NAT Device:** Inside the Hub VPC, deploy a Network Virtual Appliance (NVA) from the Marketplace (e.g., Palo Alto, Cisco, Fortinet) or a custom Linux router VM.
    3.  **Establish Connectivity:** Connect your on-prem network to this Hub VPC using Cloud VPN or Interconnect with Cloud Router.
    4.  **Peer Hub VPC with Gemini VPC:** Connect the Hub VPC to the Gemini VPC (with the overlapping IPs) using VPC Network Peering.
    5.  **Configure NAT Rules on the NVA:**
        *   **Destination NAT (DNAT):** Allocate a non-conflicting "proxy" IP range (e.g., `10.200.0.0/16`). On-prem traffic destined for a proxy IP (e.g., `10.200.10.5`) is routed to the NVA. The NVA translates the destination to the real internal IP in the conflicting VPC (e.g., `10.10.10.5`).
        *   **Source NAT (SNAT):** For return traffic, the NVA translates the source IP from the real IP back to the proxy IP before sending it to the on-prem network.
*   **Pros:** Solves the overlapping IP problem without re-architecting existing networks.
*   **Cons:** Adds complexity, cost, potential performance bottleneck (the NVA), and requires NAT rule management.

    **Implementation Details for NAT Solution:**

    *   **On-Prem to Hub VPC Connection:** Use Cloud VPN or Cloud Interconnect. Cloud Router will manage dynamic routes between the on-premise network and the Hub VPC.
    *   **Hub VPC to Gemini VPC Connection:** Use **VPC Network Peering**. Since the Hub VPC has a unique IP range, it can be peered with the Gemini VPC (which has the overlapping IP range). This allows the NVA in the Hub VPC to route traffic to/from the internal IPs in the Gemini VPC.
    *   **NVA Configuration:** The NVA is the core of this solution. It needs to be configured with:
        *   Network interfaces in appropriate subnets within the Hub VPC.
        *   Routing rules to forward traffic between the VPN/Interconnect interface and the interface connected to the peered Gemini VPC network.
        *   DNAT rules to translate destination IPs from the on-prem accessible "proxy" range to the actual Gemini VPC internal IPs.
        *   SNAT rules to translate source IPs from the Gemini VPC internal IPs back to the "proxy" range for traffic returning to the on-premise network.
    *   **Routing:**
        *   On-premise routers need static routes for the "proxy" IP range, pointing towards the Cloud VPN/Interconnect to the Hub VPC.
        *   The Hub VPC, through peering, will know how to reach the Gemini VPC's subnets.

**Solution 3: Isolate and Use Application-Level Proxies**
Suitable if only specific services need to be accessed.
*   **How it Works:** Place a proxy in a non-conflicting network that can reach into the conflicting one. On-prem users connect to the proxy.
    *   **Bastion Host:** For SSH/RDP access.
    *   **Internal Application Load Balancer:** Expose web services via an ILB in a non-conflicting VPC with backends in the conflicting VPC.
*   **Pros:** Often more secure, granular access control.
*   **Cons:** Does not provide general IP-level connectivity; per-service configuration required.

**Summary and Recommendation**

| Solution                      | How it Works                                                                                                | Pros                                    | Cons                                                              |
| :---------------------------- | :---------------------------------------------------------------------------------------------------------- | :-------------------------------------- | :---------------------------------------------------------------- |
| 1. Re-IP / Re-Architect       | Change the IP range of the new VPC to be unique.                                                            | Simple, clean, high performance.        | Highly disruptive; often not feasible.                            |
| 2. Network Address Translation (NAT) | Use a router/NVA in a hub VPC to translate between a proxy IP range and the real (conflicting) IP range. | Solves the problem without re-IPing. Flexible. | Adds complexity, cost, and a potential bottleneck.                |
| 3. Application Proxy          | Use bastion hosts or application-level load balancers to broker access to specific services.              | Secure, granular access.                | Does not provide general network connectivity.                    |

**Recommendation:** For connecting an on-premise hosted domain to an internal Google Cloud resource where a VPC has a conflicting IP, the standard enterprise solution is **#2: Implement NAT using a Network Virtual Appliance (NVA) in a dedicated hub VPC**.

## Step-by-Step Deployment Guide

This guide details the order of operations for deploying the Gemini Enterprise internal solution. Manual steps are prerequisites for the Terraform-managed resources.

**Phase 1: Manual Prerequisites & Connectivity**

1.  **Create Google Groups:**
    *   Manually create the following Google Groups in your Google Workspace domain:
        *   `gcp-gemini-enterprise-admins@<your-domain>`
        *   `gcp-gemini-enterprise-users@<your-domain>`

2.  **Establish Hybrid Connectivity:**
    *   Configure Cloud VPN or Cloud Interconnect between your on-premise network and the intended GCP region.
    *   Configure Cloud Router to exchange routes between on-premise and GCP.

3.  **Identify Internal DNS & CA:**
    *   Know how to access and modify your internal DNS server.
    *   Know the process to request and receive a signed SSL certificate from your internal Certificate Authority.

**Phase 2: Terraform Deployment - Stage 0 (Core Infrastructure)**

*   Navigate to `blueprints/fedramp-high/gemini-enterprise/internal-deployment/gemini-stage-0/`
*   Run `terraform init`, `terraform plan`, then `terraform apply`.
    *   **Key Output:** Note the reserved internal IP address for the load balancer from the `google_compute_address.gemini_enterprise_internal_ip` resource.

    **Resource Creation Order (as per Terraform):**

    1.  **VPC and Subnets (`network.tf`):** Creates the network and subnets.
    2.  **Reserved IP Address (`network.tf`):** Reserves `google_compute_address "gemini_enterprise_internal_ip"`.
    3.  **Cloud Armor Policy (`cloudarmor.tf`):** Deploys WAF policy.
    4.  **KMS Resources (`discovery-engine.tf`):** Sets up CMEK keys.
    5.  **GCS Bucket (`discovery-engine.tf`):** Creates bucket for Discovery Engine.
    6.  **BigQuery Dataset & Table (`discovery-engine.tf`):** Creates BQ resources.
    7.  **KMS IAM Bindings (`discovery-engine.tf`):** Grants key access to service agents.
    8.  **Discovery Engine Configuration (`discovery-engine.tf`):** Configures Discovery Engine components.
    9.  **Network Endpoints (`network.tf`):** Sets up NEG for Vertex AI Search.
    10.  **Backend Service (`load_balancer.tf`):** Configures the backend NEG for the ILB.

**Phase 3: Manual DNS & Certificate Configuration**

1.  **Configure Internal DNS:**
    *   Create an 'A' record in your internal DNS server.
    *   Point the chosen hostname (e.g., `gemini-internal.mycompany.gov`) to the reserved internal IP address obtained from Stage 0's output. See [DNS Configuration](#dns-configuration-split-horizon-dns).

2.  **Provision SSL Certificate:**
    *   Generate a CSR with the Common Name matching the hostname used above.
    *   Get the CSR signed by your internal CA.
    *   Upload the signed certificate and private key to GCP Certificate Manager. See [SSL Certificate Provisioning for HTTPS](#ssl-certificate-provisioning-for-https). Note the name/ID of the uploaded certificate resource in Certificate Manager.

**Phase 4: Provision Gemini Enterprise Application**

1.  Run the `gem4gov` CLI tool as per its documentation. This will likely require outputs from Stage 0. Note any outputs, such as a `gemini_config_id`.

**Phase 5: Terraform Deployment - Stage 1 (Load Balancer & IAP)**

*   Navigate to `blueprints/fedramp-high/gemini-enterprise/internal-deployment/gemini-stage-1/`
*   Update `terraform.tfvars` or variables to include:
    *   The name/ID of the Certificate Manager certificate.
    *   The `gemini_config_id` from Phase 4.
*   Run `terraform init`, `terraform plan`, then `terraform apply`.

    **Resource Creation Order (as per Terraform):**

    2.  **URL Maps (`load_balancer.tf`):** Sets up HTTP -> HTTPS redirect and main URL map.
    3.  **Target Proxies (`load_balancer.tf`):** Creates HTTP and HTTPS proxies. The HTTPS proxy links to the Certificate Manager certificate.
    4.  **Forwarding Rules (`load_balancer.tf`):** Exposes the ILB on the reserved internal IP.
    5.  **IAP IAM Bindings (`load_balancer.tf`):** Secures the backend service with IAP.

**Phase 6: Verification**

1.  **Test Access:** From an on-premise machine, try to access the service using the configured DNS name (e.g., `https://gemini-internal.mycompany.gov`).
2.  **Verify Certificate:** Check the browser to ensure the correct internal certificate is being presented.

## Resources Created / Necessary

### Stage 0: Core Infrastructure Resources

**Groups:**
Manual:
*   gcp-gemini-enterprise-admins@<your-domain>
*   gcp-gemini-enterprise-users@<your-domain>

**Network Configuration (network.tf)**
Manual:
*   Cloud VPN / Cloud Interconnect
    *   The customer needs a way to connect to GCP if the deployment is internal.
*   Cloud Router
    *   Cloud Router is needed to establish the from On-prem to GCP routes.
*   Certificates
    *   The customer needs a way to create a certificate, and upload it to google cloud to certificate manager
*   DNS
    *   The customer needs to point the DNS A record to the subdomain of their choosing.

Terraform:
*   **VPC and Subnets:**
    *   `google_compute_network "gemini_enterprise_vpc"`: Main VPC for deployment.
    *   `google_compute_subnetwork "gemini_enterprise_vpc_subnet"`: Subnet for the VPC.
    *   `google_compute_subnetwork "gemini_enterprise_vpc_proxy_subnet"`: Subnet for the regional managed proxy (ILB).
*   **IP Addresses:**
    *   `google_compute_address "gemini_enterprise_internal_ip"`: Reserved internal IP for internal load balancer.
*   **Network Endpoints:**
    *   `google_compute_region_network_endpoint_group "gemini_enterprise_neg"`: NEG for vertexaisearch.cloud.google.com FQDN.
    *   `google_compute_region_network_endpoint "gemini_enterprise_endpoint"`: Network endpoint for the NEG.

**Access Control (cloudarmor.tf)**
*   **WAF Policy:**
    *   `google_compute_region_security_policy "gemini_enterprise_policy"`: WAF policy to permit US traffic and deny others. As well as the OWASP Top 10.

**Discovery Engine (discovery-engine.tf)**
*   **Key Management:**
    *   `google_kms_key_ring "cmek_key_ring"`: Key ring for CMEK.
    *   `google_kms_crypto_key "cmek_crypto_key"`: CMEK key for encryption.
    *   `google_kms_crypto_key_iam_member "discoveryengine_sa_kms_access"`: IAM binding for Discovery Engine SA access to CMEK.
    *   `google_kms_crypto_key_iam_member "gcs_sa_kms_access"`: IAM binding for GCS SA access to CMEK.
    *   `google_kms_crypto_key_iam_member "bq_sa_kms_access"`: IAM binding for BigQuery SA access to CMEK.
*   **Discovery Engine Configuration:**
    *   `google_discovery_engine_cmek_config "default"`: Configures default CMEK for Discovery Engine.
    *   `google_storage_bucket "gemini_enterprise_data"`: GCS buckets as data sources.
    *   `google_discovery_engine_data_store "gemini_enterprise_gcs_ds"`: Data stores for GCS buckets.
    *   `google_bigquery_dataset "gemini_enterprise_bq_ds"`: BigQuery datasets for connectors.
    *   `google_bigquery_table "gemini_enterprise_bq_table"`: BigQuery tables.
    *   `google_discovery_engine_data_connector "gemini_enterprise_bq_connector"`: Connectors for BigQuery tables.
    *   `time_sleep "wait_for_bq_datastore"`: Delay for data store creation.
    *   `google_discovery_engine_acl_config "gemini_enterprise_acl_config"`: Configures ACLs for Discovery Engine.

### Stage 1: Load Balancer and Access Configuration Resources

**Load Balancer (load_balancer.tf)**
*   **Backend and URL Maps:**
    *   `google_compute_region_backend_service "gemini_enterprise_backend"`: Backend service for the ILB.
    *   `google_compute_region_url_map "gemini_enterprise_https_url_map"`: URL map for HTTPS routing.
    *   `google_compute_region_url_map "gemini_enterprise_http_redirect_url_map"`: URL map for HTTP to HTTPS redirection.
*   **Proxies and Forwarding Rules:**
    *   `google_compute_region_target_https_proxy "gemini_enterprise_https_proxy"`: Target HTTPS proxy using customer SSL certificate from Certificate Manager.
    *   `google_compute_region_target_http_proxy "gemini_enterprise_http_proxy"`: Target HTTP proxy for redirection.
    *   `google_compute_forwarding_rule "gemini_enterprise_https_forwarding_rule"`: Forwarding rule for HTTPS traffic.
    *   `google_compute_forwarding_rule "gemini_enterprise_http_forwarding_rule"`: Forwarding rule for HTTP traffic.

**IAP Access (load_balancer.tf)**
*   **IAM Members:**
    *   `google_iap_web_region_backend_service_iam_member "iap_admin"`: Grants IAP access to admin group.
    *   `google_iap_web_region_backend_service_iam_member "iap_user"`: Grants IAP access to user group.