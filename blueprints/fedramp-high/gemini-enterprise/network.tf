# -----------------------------------------------------------------------------
# Internet NEG for vertexaisearch.cloud.google.com
# -----------------------------------------------------------------------------
resource "google_compute_region_network_endpoint_group" "gemini_enterprise_neg" {
  name = "gemini-enterprise-internet-neg"

  project               = var.main_project_id
  network               = data.google_compute_network.network.id
  network_endpoint_type = "INTERNET_FQDN_PORT"
  region                = var.region
}

resource "google_compute_region_network_endpoint" "gemini_enterprise_endpoint" {
  project                       = var.main_project_id
  region_network_endpoint_group = google_compute_region_network_endpoint_group.gemini_enterprise_neg.name
  region                        = var.region
  fqdn                          = "vertexaisearch.cloud.google.com"
  port                          = 443
}

resource "google_compute_region_health_check" "default" {
  name    = "dummy-health-check"
  project = var.main_project_id
  region  = var.region
  tcp_health_check {
    port = 443
  }
}

