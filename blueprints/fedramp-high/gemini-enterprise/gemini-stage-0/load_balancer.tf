# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Define the Backend Service on the Load Balancer and integrate all components.
resource "google_compute_region_backend_service" "gemini_enterprise_backend" {
  name                  = "gemini-enterprise-backend-service"
  project               = var.main_project_id
  protocol              = "HTTPS"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  region                = var.region


  # Attach the Internet NEG
  backend {
    group           = google_compute_region_network_endpoint_group.gemini_enterprise_neg.id
    capacity_scaler = 1.0
  }

  # Enable IAP
  iap {
    enabled = true
  }

  log_config {
    enable = true
    sample_rate = 1
  }
}

# This is an optional but recommended companion to the HTTPS setup,
# creating an HTTP load balancer to redirect HTTP traffic to HTTPS.
resource "google_compute_region_url_map" "gemini_enterprise_http_redirect_url_map" {
  project     = var.main_project_id
  name        = "${var.prefix}-http-redirect-url-map"
  region      = var.region
  description = "URL map to redirect HTTP to HTTPS"

  default_url_redirect {
    https_redirect         = true
    strip_query            = false
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
  }
}

resource "google_compute_region_target_http_proxy" "gemini_enterprise_http_proxy" {
  project    = var.main_project_id
  name       = "${var.prefix}-http-proxy"
  region     = var.region
  url_map    = google_compute_region_url_map.gemini_enterprise_http_redirect_url_map.id
}

resource "google_compute_forwarding_rule" "gemini_enterprise_forwarding_rule" {
  project               = var.main_project_id
  name                  = "${var.prefix}-http-forwarding-rule"
  region                = var.region
  ip_protocol           = "TCP"
  port_range            = "80" # HTTP port
  load_balancing_scheme = "EXTERNAL_MANAGED" # Changed to EXTERNAL_MANAGED
  network               = google_compute_network.gemini_enterprise_vpc.self_link
  ip_address            = google_compute_address.gemini_enterprise_ip.address
  target                = google_compute_region_target_http_proxy.gemini_enterprise_http_proxy.id
  
  depends_on = [ time_sleep.wait_for_org_policy ]
}