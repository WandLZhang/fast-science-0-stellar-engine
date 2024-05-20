/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#Terraform Provider for Google Cloud Platform
provider "google" {
  project = var.project_id
  region  = var.region
} #data #resources #module #commented out code 
#Google KMS Module
module "kms" {
  source     = "../../../modules/kms"
  project_id = var.project_id
  keys       = var.keys 
  iam = {
    "roles/cloudkms.cryptoKeyEncrypterDecrypter" = ["user:${data.google_bigquery_default_service_account.bq_sa.member}","serviceAccount:${data.google_bigquery_default_service_account.bq_sa.email}"]
  }
  keyring    = var.keyring
  }
data "google_project" "current" {}
data "google_bigquery_default_service_account" "bq_sa" {}

# resource "google_kms_crypto_key_iam_member" "key_sa_user" {
#   crypto_key_id = module.kms.keys.default.id
#   role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   member        = "serviceAccount:${data.google_bigquery_default_service_account.bq_sa.email}"
# }
# Obtain the Cloud Storage Service Account
# locals {
#   big_query_service_account = "service-${data.google_project.current.number}@bigquery-encryption.iam.gserviceaccount.com"
# }

# Google IAM Policy to the user as Admin
# data "google_iam_policy" "admin" {
#   binding {
#     role = "roles/storage.admin"
#     members = [
#       "user:${var.email}"
#     ]
#   }
# }
module "bigquery-dataset" {
  source                     = "../../../modules/bigquery-dataset"
  location                   = "us-east4"
  project_id                 = var.project_id
  id                         = var.id
  description                = "This dataset has customer managed encrytped keys, is updated in real-time, and accessed by restricted roles."
  encryption_key             = module.kms.keys.default.id
}









