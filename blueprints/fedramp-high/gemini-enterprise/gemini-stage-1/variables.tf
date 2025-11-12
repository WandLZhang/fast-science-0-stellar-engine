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

variable "access_policy_number" {
  description = "There can only be one Access Policy per GCP Org. Use gcloud access-context-manager policies list --organization <org-number> to list it."
  type        = number
}

variable "domain" {
  description = "the domain of the google organization"
  type        = string
}

variable "main_project_id" {
  description = "The GCP Project name."
  type        = string
}

variable "prefix" {
  description = "Prefix for naming resources in this blueprint."
  type        = string
  default     = "cnap"
}

variable "region" {
  description = "GCP Region to deploy into."
  type        = string
}

variable "gemini_enterprise_domain" {
  description = "Your domain that you associated the reserved IP from stage 0 to"
  type        = string
  default     = "prod"
}

# Variable for the customer-provided SSL certificate name
variable "ssl_certificate_name" {
  description = "The name of the pre-uploaded SSL certificate in Google Cloud."
  type        = string
}

variable "gemini_config_id" {
  description = "ID for your Gemini Enterprise instance after running Gem4Gov CLI"
  type        = string
}

variable "admin_group" {
  description = "The principal of the Gemini Enterprise administrators group."
  type        = string
}

variable "user_group" {
  description = "The principal of the Gemini Enterprise users group."
  type        = string
}

