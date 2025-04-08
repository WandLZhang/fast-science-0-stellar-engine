data "google_project" "project" {}

# Service Identity is required to enable encryption for the tables in the bigtable instance, without this account only the clusters will be encrypted
resource "google_project_service_identity" "bigtable_sa" {
  provider = google-beta
  project  = var.main_project_id
  service  = "bigtableadmin.googleapis.com"
}

# Grant Bigtable Service Account access to
resource "google_kms_crypto_key_iam_member" "bigtable_sa_kms_access" {
  crypto_key_id = var.kms_key_name
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = google_project_service_identity.bigtable_sa.member
}

# Create bigtable instance
module "bigtable-instance" {
  source         = "../../../modules/bigtable-instance"
  project_id     = var.main_project_id
  name           = var.instance_name
  encryption_key = var.kms_key_name
  clusters = {
    (var.cluster_id) = {
      cluster_id   = var.cluster_id
      zone         = var.zone
      num_nodes    = var.num_nodes
      storage_type = var.storage_type
    }
  }
  tables              = var.table
  deletion_protection = false
}
