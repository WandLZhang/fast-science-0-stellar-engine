data "google_project" "current" {
  project_id = var.project_id
}

resource "google_service_account" "composer" {
  project      = var.project_id
  account_id   = var.sa_account_id
  display_name = var.sa_display_name
}

resource "google_composer_environment" "main" {
  provider = google-beta # Required for private IP

  project = var.project_id
  name    = var.composer_env_name
  region  = var.region

  config {
    enable_private_environment = true
    software_config {
      image_version = var.composer_version
    }

    node_config {
      network         = var.network
      subnetwork      = var.subnet
      service_account = google_service_account.composer.name
    }
  }

  depends_on = [
    google_project_iam_member.composer_worker,
    google_project_iam_member.composer_service_agent,
    google_project_iam_member.composer_network_user,
    google_project_iam_member.composer_vpc_agent
  ]
}
