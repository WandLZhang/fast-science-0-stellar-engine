resource "google_project_service" "datastore_api" {
  project            = var.main_project_id
  service            = "datastore.googleapis.com"
  disable_on_destroy = false
}


# Requires App Engine Instance
module "datastore" {
  source  = "terraform-google-modules/cloud-datastore/google"
  version = "~> 2.0"
  project = var.main_project_id
  indexes = file("index.yaml")

  depends_on = [google_project_service.datastore_api]
}
