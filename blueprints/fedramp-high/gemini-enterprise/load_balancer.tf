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

module "cnap-0-redirect" {
  source     = "../../../modules/net-lb-app-ext-regional/"
  project_id = var.network_project_id
  name       = "${var.prefix}-cloud-native-access-point-redirect"
  vpc        = data.google_compute_network.network.self_link
  region     = var.region
  address = (
    google_compute_address.cnap-ext-ip.id
  )
  health_check_configs = {}
  urlmap_config = {
    description = "URL redirect for ${var.prefix}-cloud-native-access-point."

    default_url_redirect = {
      https         = true
      response_code = "MOVED_PERMANENTLY_DEFAULT"
    }
  }
}

resource "google_compute_region_url_map" "gemini_url_map" {
  project         = var.network_project_id
  region          = var.region
  name            = "${var.prefix}-gemini-url-map"
  default_service = google_compute_region_backend_service.gemini_enterprise_backend.id
}

resource "google_compute_region_health_check" "default" {
  name    = "dummy-health-check"
  project = var.main_project_id
  region  = var.region
  tcp_health_check {
    port = 443
  }
}