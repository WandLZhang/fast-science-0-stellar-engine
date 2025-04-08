resource "google_service_account" "workstation_config_key_user" {
  project      = var.main_project_id
  account_id   = "workstation-config-kms"
  display_name = "Workstation Config Service Account"
}

resource "google_kms_crypto_key_iam_member" "workstations_sa_kms_permissions" {
  crypto_key_id = local.key
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_service_account.workstation_config_key_user.email}"
}

resource "google_project_iam_member" "network_user" {
  project    = var.network_project_id
  role       = "roles/compute.networkUser"
  member     = local.workstation_default_sa
  depends_on = [google_project_service.workstations]
}

resource "google_project_iam_member" "artifact_registry_reader" {
  project    = var.main_project_id
  role       = "roles/artifactregistry.reader"
  member     = local.compute_default_sa
  depends_on = [google_project_service.workstations]
}