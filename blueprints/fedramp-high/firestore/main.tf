module "firestore" {
  source     = "../../../modules/firestore"
  project_id = var.project_id
  database = {
    name        = var.database_name
    location_id = var.location_id
    type        = "FIRESTORE_NATIVE"

    # Please refer to https://cloud.google.com/firestore/docs/cmek to request access to this feature.
    # cmek_config = {
    #   kms_key_name = var.kms_key_name 
    # }
  }

  backup_schedule = var.backup_schedule
}