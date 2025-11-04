# Vertex AI Search (Discovery Engine) Data Store Provisioning for Agent Space

This Terraform module provisions the necessary Google Cloud infrastructure to create and manage multiple data stores for Vertex AI Search, intended to be used as grounded knowledge sources for a Gemini Enterprise application.

## Resources Created

*   **KMS:** Customer-Managed Encryption Keys (CMEK) for securing data at rest.
*   **GCS Buckets:** Multiple buckets based on user-provided names for staging data.
*   **BigQuery Datasets & Tables:** Multiple datasets and tables based on user-provided configurations.
*   **Vertex AI Search Data Stores:**
    *   Data Stores linked to each created GCS bucket.
    *   Data Connectors and associated Data Stores for each BigQuery configuration.
*   **Service Enablement:** Ensures required APIs are enabled.
*   **ACL Configuration:** Common First-Party IDP configuration for access control.

## How it Works

This module focuses on creating the foundational data stores. It accepts lists of names or configurations for GCS buckets and BigQuery tables. Using `for_each`, it will iterate through these lists and provision:

1.  An empty GCS bucket for each name in the `gcs_data_store_names` variable.
2.  A corresponding empty Vertex AI Search Data Store linked to that GCS bucket.
3.  An empty BigQuery Dataset and Table for each object in the `bq_data_store_configs` variable.
4.  A Vertex AI Search Data Connector linked to the BigQuery table, which in turn creates the Data Store.

**Important:** The created GCS buckets and BigQuery tables will be *empty*. Users must manually populate these resources with their data and then trigger an import/reindex process within Vertex AI Search.

The Gemini Enterprise application itself is NOT created by this Terraform. Instead, the "gem for Gov CLI" tool will be used to create the application and link it to the Data Store IDs output by this module.

## Usage

1.  Create a `terraform.tfvars` file in this directory.
2.  Define values for the variables in `variables.tf`:
    *   `main_project_id`, `region`, `geolocation`
    *   `gcs_data_store_names`: A list of strings, where each string is the desired name for a GCS bucket and the basis for the Data Store ID.
    *   `bq_data_store_configs`: A list of objects, where each object has `dataset_id` and `table_id` attributes for your BigQuery sources.
3.  Initialize Terraform: `terraform init`
4.  Review the plan: `terraform plan`
5.  Apply the configuration: `terraform apply`

The outputs will provide the names and IDs of the created Data Stores.

### Example `terraform.tfvars`

```terraform
main_project_id = "your-gcp-project-id"
region          = "us-central1"
geolocation     = "us"

# Example GCS Data Stores
gcs_data_store_names = ["company-docs", "knowledge-base"]

# Example BigQuery Data Stores
bq_data_store_configs = [
  {
    dataset_id = "internal_wiki"
    table_id   = "articles"
  },
  {
    dataset_id = "product_data"
    table_id   = "specs"
  }
]
```

## Manual Data Import

*   **GCS:** After `terraform apply`, upload your documents to the created GCS buckets. Then, use the gcloud CLI or Cloud Console to import data from the GCS bucket into the corresponding Data Store. Example:
    ```bash
    # Run this for each GCS Data Store
    gcloud discovery-engine data-stores import <DATA_STORE_ID> \
      --project=<PROJECT_ID> \
      --location=<GEOLOCATION> \
      --gcs-source=gs://<BUCKET_NAME>/* \
      --data-schema=content
    ```
*   **BigQuery:** Ensure your BigQuery tables are populated with data matching the schema expected by the connector. The connector will periodically refresh.

# How to populate the bigquery table / point to public documentation.

## Application Layer

The "gem for Gov CLI" tool will handle the creation of the Gemini Enterprise application. This tool will:

1.  Prompt the user for the Data Store ID(s) (from the Terraform outputs) to connect to the application.
2.  Support single Data Store (standard search) or multiple Data Stores (blended search).
3.  Apply necessary feature flags and configurations (like disabling analytics) to the application, which are not yet fully supported in the Terraform provider.

## Gap Analysis & Plan for `discovery-engine.tf`

**Current State:**

*   Creates a single hardcoded GCS bucket and Data Store.
*   Creates a single hardcoded sample BigQuery dataset/table and Connector.
*   Does not support lists of inputs for dynamic resource creation.
*   Commented out `google_discovery_engine_search_engine` resources due to provider limitations (e.g., `disable_analytics` flag missing).

**Desired State:**

*   Accept `gcs_data_store_names` list as input.
*   Accept `bq_data_store_configs` list of objects as input.
*   Use `for_each` to create `google_storage_bucket` and `google_discovery_engine_data_store` resources based on `gcs_data_store_names`.
*   Use `for_each` to create `google_bigquery_dataset`, `google_bigquery_table`, and `google_discovery_engine_data_connector` resources based on `bq_data_store_configs`.
*   Remove all sample/hardcoded GCS and BigQuery resources.
*   Output lists of created Data Store IDs.

**Implementation Plan:**

1.  **Update `variables.tf`:**
    *   Add `variable "gcs_data_store_names"` (type: `list(string)`, default: `[]`).
    *   Add `variable "bq_data_store_configs"` (type: `list(object({ dataset_id = string, table_id = string }))`, default: `[]`).
2.  **Refactor GCS Resources in `discovery-engine.tf`:**
    *   Add `for_each` to `google_storage_bucket.agent_space_data` based on `var.gcs_data_store_names`. Use `each.key` or `each.value` for naming.
    *   Add `for_each` to `google_discovery_engine_data_store.agent_space_gcs_ds` based on `var.gcs_data_store_names`. Link to the dynamically created bucket.
3.  **Refactor BigQuery Resources in `discovery-engine.tf`:**
    *   Remove sample `google_bigquery_dataset` and `google_bigquery_table`.
    *   Add `google_bigquery_dataset` resource with `for_each` based on `var.bq_data_store_configs` to create the datasets.
    *   Add `google_bigquery_table` resource with `for_each` based on `var.bq_data_store_configs` to create the tables within the dynamically created datasets.
    *   Add `for_each` to `google_discovery_engine_data_connector.agent_space_bq_connector` based on `var.bq_data_store_configs`.
    *   The `params` and `entities` blocks within the connector will use `each.value.dataset_id` and `each.value.table_id`.
4.  **Update `outputs.tf`:**
    *   Modify outputs to return maps or lists of the dynamically created resource attributes.
5.  **Testing:** Apply with various inputs in `terraform.tfvars` to ensure correct resource creation.
