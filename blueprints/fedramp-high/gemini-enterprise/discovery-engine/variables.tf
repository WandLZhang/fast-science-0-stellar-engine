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

variable "main_project_id" {
  description = "The main project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources like KMS"
  type        = string
}

variable "geolocation" {
  description = "Location for Discovery Engine resources (us, eu, or global)."
  type        = string
  default     = "us"
}

variable "gcs_data_store_names" {
  description = "A list of names to use for creating GCS buckets and associated Discovery Engine Data Stores."
  type        = list(string)
  default     = []
}

variable "bq_data_store_configs" {
  description = "A list of objects defining BigQuery datasets and tables to create and connect to Discovery Engine. Each object should have 'dataset_id' and 'table_id'."
  type        = list(object({
    dataset_id = string
    table_id   = string
  }))
  default     = []
}