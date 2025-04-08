resource "google_project_service" "datafusion_api" {
  project            = var.main_project_id
  service            = "datafusion.googleapis.com"
  disable_on_destroy = false
}

module "datafusion" {
  source                   = "../../../modules/datafusion-se"
  name                     = var.name
  region                   = var.region
  project_id               = var.main_project_id
  network                  = var.network_name
  subnet                   = var.subnetwork_name
  firewall_create          = false
  landing_project_id       = var.network_project_id
  dataproc_service_account = google_service_account.datafusion.email
  private_instance         = true
  kms_key                  = var.kms_key_name
  ip_allocation_create     = false
  network_peering          = false

  depends_on = [google_project_service.datafusion_api]
}
