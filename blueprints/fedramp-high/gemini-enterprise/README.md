# Gemini Enterprise for FedRAMP High Blueprint

This blueprint deploys a secure and compliant environment for hosting Gemini Enterprise on Google Cloud Platform, specifically tailored for FedRAMP High requirements. It leverages Vertex AI Search and Discovery Engine. The deployment is divided into two main Terraform stages (`gemini-stage-0` and `gemini-stage-1`) and interacts with the `gem4gov` CLI tool.

**This blueprint supports both EXTERNAL and INTERNAL load balancer deployments, configurable via the `deployment_type` variable in `gemini-stage-0/terraform.tfvars` and `gemini-stage-1/terraform.tfvars`.**

**For an internal-only deployment (no external load balancer), please refer to more details within [internaldeployment.md](./internaldeployment.md).**

## Overall Goal

The primary goal is to provide a turnkey solution for setting up Gemini Enterprise, enabling government customers and other regulated entities to utilize its AI-powered search and assistant capabilities while adhering to strict security and compliance mandates.

## Architecture Overview

The blueprint establishes a robust infrastructure including:

1.  **Dedicated Networking:** A new VPC with private subnets to isolate the environment. The IP range for the subnet used by the internal load balancer can be customized via the `internal_lb_subnet_range` variable in `gemini-stage-0`.
2.  **Data Storage:** CMEK-encrypted Google Cloud Storage (GCS) buckets and BigQuery datasets to securely store data for Discovery Engine.
3.  **Discovery Engine:** Configuration of Discovery Engine data stores, and connectors for GCS and BigQuery.
4.  **Load Balancing:** A Regional HTTPS Load Balancer (either INTERNAL_MANAGED or EXTERNAL_MANAGED based on `deployment_type`) to securely expose the Gemini Enterprise application.
5.  **Security Controls:**
    *   **Identity-Aware Proxy (IAP):** Enforces fine-grained access control based on user identity and context.
    *   **Access Context Manager:** Defines and enforces granular access policies based on attributes like user identity, device security status, time of day, and geo-location.
    *   **Cloud Armor:** Provides WAF capabilities and DDoS protection, initially configured to only allow traffic from the US (Applicable for EXTERNAL deployments).
    *   **CMEK:** Ensures data at rest in GCS, BigQuery, and Discovery Engine is encrypted with customer-managed keys.
    *   **IAM:** Least privilege IAM roles and service accounts.
    *   **Org Policies:** Enforces organizational constraints to maintain compliance.

## Deployment Stages

### Stage 0: Infrastructure Foundation (`gemini-stage-0`)

This stage provisions the core infrastructure.

**Key Variables:**

*   `deployment_type`: Set to `"internal"` or `"external"`.
*   `internal_lb_subnet_range`: Customize the subnet range for the ILB if `deployment_type` is `"internal"`.

**Key Resources Created:**

| Resource Type                                     | Name/Purpose                                                | File                   |
| :------------------------------------------------ | :---------------------------------------------------------- | :--------------------- |
| APIs Enabled                                      | Discovery Engine, KMS, BQ, GCS, IAP, ACM, etc.              | `main.tf`              |
| Service Identities                                | Discovery Engine, Cloud Storage, & IAP Service Agents                              | `main.tf`              |
| `google_compute_network`                          | `gemini-enterprise-vpc`                                     | `network.tf`           |
| `google_compute_subnetwork`                       | General & Proxy Subnets                                     | `network.tf`           |
| `google_compute_address`                          | Static Internal or External IP for LB                       | `network.tf`           |
| `google_compute_region_network_endpoint_group`    | Internet NEG for `vertexaisearch.cloud.google.com`          | `network.tf`           |
| `google_kms_key_ring`                             | `gemini-enterprise-cmek-keyring`                            | `discovery-engine.tf`  |
| `google_kms_crypto_key`                           | `gemini-enterprise-cmek-key` (CMEK)                         | `discovery-engine.tf`  |
| `google_kms_crypto_key_iam_member`                | Grant CMEK perms to SAs                                     | `discovery-engine.tf`  |
| `google_discovery_engine_cmek_config`             | Default CMEK for Discovery Engine                           | `discovery-engine.tf`  |
| `google_storage_bucket`                           | CMEK-encrypted buckets for data stores                      | `discovery-engine.tf`  |
| `google_discovery_engine_data_store`              | GCS Data Stores                                             | `discovery-engine.tf`  |
| `google_bigquery_dataset`                         | CMEK-encrypted datasets for data stores                     | `discovery-engine.tf`  |
| `google_bigquery_table`                           | BQ Tables                                                   | `discovery-engine.tf`  |
| `google_discovery_engine_data_connector`          | BQ Connectors                                               | `discovery-engine.tf`  |
| `google_discovery_engine_acl_config`              | GSUITE IDP for Discovery Engine                             | `discovery-engine.tf`  |
| `google_project_iam_member`                       | Admin/User Group Roles                                      | `iam.tf`               |
| `google_access_context_manager_access_levels`     | US, Time, Device, etc. Access Levels                        | `access_policy.tf`     |
| `google_compute_region_security_policy`           | Cloud Armor: Allow US, Deny Others                          | `cloudarmor.tf`        |
| `google_org_policy_policy`                        | Allow EXTERNAL_MANAGED LB                                   | `org-policy.tf`        |
| `google_compute_region_backend_service`           | Backend for HTTP Redirect                                   | `load_balancer.tf`     |
| `google_compute_region_url_map`                   | HTTP to HTTPS Redirect URL Map                              | `load_balancer.tf`     |
| `google_compute_region_target_http_proxy`         | HTTP Proxy for Redirect                                     | `load_balancer.tf`     |
| `google_compute_forwarding_rule`                  | Port 80 HTTP Redirect Rule                                  | `load_balancer.tf`     |

**Prerequisites for Stage 0:**

*   Chrome Enterprise Premium enabled.
*   Google Workspace Groups (`gcp-gemini-enterprise-admins`, `gcp-gemini-enterprise-users`) created.
*   OAuth Consent Screen configured.
*   A clean FedRAMP High GCP project.
*   Update `terraform.tfvars` with desired `deployment_type` and `internal_lb_subnet_range` if needed.

**Manual Steps After Stage 0:**

*   Populate GCS buckets and BigQuery tables with data.
*   Manually trigger data import from GCS to Discovery Engine.

### The `gem4gov` CLI Tool

This CLI tool is run *between* Stage 0 and Stage 1. Its main purpose is to:

*   Authenticate the user and validate permissions.
*   Configure the Identity Provider for Discovery Engine.
*   Register the CMEK key with Discovery Engine.
*   Create/Select Discovery Engine Data Stores.
*   **Provision the Gemini Enterprise Search Engine, linking the data stores.**
*   Apply compliance configurations (e.g., disable non-FedRAMP compliant features).
*   Output the **`config_id`** (Customer ID) required for Stage 1.

### Stage 1: Load Balancer Frontend & IAP (`gemini-stage-1`)

This stage configures the main HTTPS frontend for the application.

**Key Variables:**

*   `deployment_type`: Must match the value set in Stage 0.

**Key Resources Created:**

| Resource Type                                     | Name/Purpose                                                | File                   |
| :------------------------------------------------ | :---------------------------------------------------------- | :--------------------- |
| `data "google_compute_region_ssl_certificate"`    | Retrieve uploaded SSL Certificate                           | `load_balancer.tf`     |
| `google_compute_region_url_map`                   | Main HTTPS URL Map (`gemini_enterprise_load_balancer`) with path rewriting | `load_balancer.tf`     |
| `google_compute_region_target_https_proxy`        | HTTPS Proxy with SSL Cert                                   | `load_balancer.tf`     |
| `google_compute_forwarding_rule`                  | Main Port 443 HTTPS Rule                                    | `load_balancer.tf`     |
| `google_iap_web_backend_service_iam_member`       | IAP access for Admin group (Strict device)                  | `load_balancer.tf`     |
| `google_iap_web_backend_service_iam_member`       | IAP access for User group (Moderate device)                 | `load_balancer.tf`     |

**Prerequisites for Stage 1:**

*   Stage 0 successfully applied.
*   `gem4gov onboard` CLI process completed, obtaining the `customer_id`.
*   SSL Certificate uploaded to Google Cloud Certificate Manager.
*   DNS 'A' record pointing to the static IP from Stage 0.
*   `terraform.tfvars` file updated with `customer_id`, `ssl_certificate_name`, `deployment_type`, etc.

## Security and Compliance

*   **Data Residency:** Resources are regionalized, and KMS keys are in the "us" multi-region to meet data residency requirements.
*   **Encryption:** CMEK is used for GCS, BigQuery, and Discovery Engine. Data in transit is protected by HTTPS.
*   **Access Control:** IAP and Access Context Manager provide strong, context-aware access control. Cloud Armor filters traffic at the edge.
*   **Least Privilege:** IAM roles are scoped to minimize permissions.

## Deployment Flow

1.  Meet prerequisites for Stage 0.
2.  Configure `gemini-stage-0/terraform.tfvars`, paying attention to `deployment_type`.
3.  Apply Stage 0 Terraform: `terraform init`, `terraform apply`.
4.  Perform manual steps after Stage 0 (data loading).
5.  Run the `gem4gov onboard` CLI to configure the application engine and get the `customer_id`.
6.  Meet prerequisites for Stage 1 (SSL cert, DNS).
7.  Configure `gemini-stage-1/terraform.tfvars`, ensuring `deployment_type` matches Stage 0.
8.  Apply Stage 1 Terraform: `terraform init`, `terraform apply`.

This multi-stage approach ensures that infrastructure is in place before application-level configuration and frontend exposure, maintaining a secure and orderly deployment.
