resource "google_service_account" "workflow_sa" {
  account_id   = "workflows-sa"
  display_name = "Workflows Service Account."
}

module "workflows" {
  source          = "../../../modules/workflows"
  project         = var.project
  name            = var.name
  region          = var.region
  description     = var.description
  logging_level   = var.logging_level
  env_vars        = var.env_vars
  key             = var.key
  file            = var.file
  service_account = google_service_account.workflow_sa.email

  depends_on = [ google_service_account.workflow_sa ]
}