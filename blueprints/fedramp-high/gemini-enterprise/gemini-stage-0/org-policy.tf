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

# These org policies are made as part of the blueprint.
# The purpose of this blueprint is when you have a fresh GCP-Project, you can assign this and it will spin up a Gemini Enterprise App for you.
# This works in combination with Gem4Gov CLI.

resource "google_org_policy_policy" "allow_external_lb" {
  count  = var.deployment_type == "external" ? 1 : 0
  name   = "projects/${data.google_project.project.number}/policies/compute.restrictLoadBalancerCreationForTypes"
  parent = "projects/${data.google_project.project.number}"
  spec {
    inherit_from_parent = true

    rules {
      values {
        allowed_values = ["EXTERNAL_MANAGED_HTTP_HTTPS"]
      }

    }
  }
}

resource "time_sleep" "wait_for_org_policy" {
  create_duration = "120s"

  depends_on = [
    google_org_policy_policy.allow_external_lb
  ]
}
#TODO: Test Custom org-policy kmsRotationsedev: to make exception to launch Gemini Enterprise with CMEK.