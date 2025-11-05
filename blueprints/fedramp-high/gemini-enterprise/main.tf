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


## Data Variables + Enabling APIs ##

data "google_project" "project" {
  project_id = var.main_project_id
}

data "google_project" "landing_project" {
  project_id = var.network_project_id
}

resource "google_project_service" "services" {
  project = var.main_project_id
  for_each = toset([
    "discoveryengine.googleapis.com",
    "cloudkms.googleapis.com",
    "bigquery.googleapis.com",
    "storage.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "beyondcorp.googleapis.com",
    "binaryauthorization.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "orgpolicy.googleapis.com",
    "serviceusage.googleapis.com",
    "secretmanager.googleapis.com" # Added Secret Manager API
  ])
  service = each.value
  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false

}

resource "google_project_service" "net-host-services" {
  project = var.network_project_id
  for_each = toset([
    "accesscontextmanager.googleapis.com",
    "beyondcorp.googleapis.com",
    "binaryauthorization.googleapis.com",
    "compute.googleapis.com",
    "ids.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "orgpolicy.googleapis.com",
    "run.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com"
  ])
  service = each.value
  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false

}

# 1. Data sources to securely fetch the OAuth credentials from Secret Manager.
data "google_secret_manager_secret_version" "iap_client_id" {
  secret  = "iap-client-id" # The name of the secret you created
  project = var.main_project_id
}

data "google_secret_manager_secret_version" "iap_client_secret" {
  secret  = "iap-client-secret" # The name of the secret you created
  project = var.main_project_id
}

# 2. Define the Backend Service and integrate all components.
resource "google_compute_region_backend_service" "gemini_enterprise_backend" {
  name                  = "gemini-enterprise-backend-service"
  project               = var.main_project_id
  protocol              = "HTTPS"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  region                = var.region


  # Attach the Internet NEG from Phase 2.
  backend {
    group           = google_compute_region_network_endpoint_group.gemini_enterprise_neg.id
    capacity_scaler = 1.0
  }

  # Enable IAP using the credentials from Secret Manager.
  iap {
    enabled              = true
    oauth2_client_id     = data.google_secret_manager_secret_version.iap_client_id.secret_data
    oauth2_client_secret = data.google_secret_manager_secret_version.iap_client_secret.secret_data
  }
}

# 3. Grant a user or group access through IAP.
# Due to provider issues, this IAM binding must be managed manually, see README.md
# resource "google_iap_web_backend_service_iam_member" "iap_user" {
#   project             = var.main_project_id
#   web_backend_service = "projects/${data.google_project.project.number}/iap_web/compute-${var.region}/services/${google_compute_region_backend_service.gemini_enterprise_backend.name}"
#   role                = "roles/iap.httpsResourceAccessor"
#   member              = "group:gcp-agentspace-users@shuttontest.joonix.net"
# }