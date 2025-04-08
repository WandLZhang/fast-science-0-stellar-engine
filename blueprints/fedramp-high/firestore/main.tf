resource "google_project_service" "datastore_api" {
  project            = var.main_project_id
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}
module "firestore" {
  source     = "../../../modules/firestore"
  project_id = var.main_project_id
  database = {
    name        = var.firestore_database_name
    location_id = var.region
    type        = "FIRESTORE_NATIVE"

    # Please refer to https://cloud.google.com/firestore/docs/cmek to request access to this feature.
    # cmek_config = {
    #   kms_key_name = var.kms_key_name
    # }
  }

  backup_schedule = var.backup_schedule

  depends_on = [google_project_service.datastore_api]
}