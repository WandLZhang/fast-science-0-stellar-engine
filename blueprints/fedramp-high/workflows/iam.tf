resource "google_service_account" "workflow_sa" {
  account_id   = "workflows-sa"
  display_name = "Workflows Service Account."
}

resource "google_kms_crypto_key_iam_member" "workflows_key_user" {
  crypto_key_id = var.key
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-workflows.iam.gserviceaccount.com"
  depends_on    = [google_project_service.workflows]
}