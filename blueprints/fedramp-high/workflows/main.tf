# Enable the API
resource "google_project_service" "workflows" {
  for_each = toset([
    "workflows.googleapis.com",
  ])
  service            = each.key
  disable_on_destroy = false
}

data "google_project" "project" {}

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

  iam = {
    "roles/workflows.invoker"                 = [google_service_account.workflow_sa.member],
    "roles/logging.logWriter"                 = [google_service_account.workflow_sa.member],
    "roles/serviceusage.serviceUsageConsumer" = [google_service_account.workflow_sa.member],
  }
  depends_on = [
    google_project_service.workflows,
    google_service_account.workflow_sa,
    google_kms_crypto_key_iam_member.workflows_key_user,
  ]
}