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

output "admin_group" {
  value       = var.admin_group
  description = "The principal for the Gemini Enterprise administrators group."
}

output "user_group" {
  value       = var.user_group
  description = "The principal for the Gemini Enterprise users group."
}

output "gemini_enterprise_ip" {
  value       = var.deployment_type == "internal" ? google_compute_address.gemini_enterprise_internal_ip[0].address : google_compute_global_address.gemini_enterprise_external_ip[0].address
  description = "The reserved IP address for the load balancer."
}

output "deployment_type" {
  value       = var.deployment_type
  description = "The deployment type of the load balancer (internal or external)."
}