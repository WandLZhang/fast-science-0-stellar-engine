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

# tfdoc:file:description Team stage resources.

# TODO(ludo): add support for CI/CD
locals {
  # FAST-specific IAM
  _envs_folder_fast_iam = !var.fast_features.envs ? {} : {
    "roles/logging.admin"                  = [module.branch-envs-sa[0].iam_email]
    "roles/owner"                          = [module.branch-envs-sa[0].iam_email]
    "roles/resourcemanager.folderAdmin"    = [module.branch-envs-sa[0].iam_email]
    "roles/resourcemanager.projectCreator" = [module.branch-envs-sa[0].iam_email]
    "roles/compute.xpnAdmin"               = [module.branch-envs-sa[0].iam_email]
  }
  # deep-merge FAST-specific IAM with user-provided bindings in var.folder_iam
  _envs_folder_iam = merge(
    var.folder_iam.envs,
    {
      for role, principals in local._envs_folder_fast_iam :
      role => distinct(concat(principals, lookup(var.folder_iam.envs, role, [])))
    }
  )
}

module "branch-envs-folders" {
  source   = "../../../modules/folder"
  for_each = var.envs_folders
  parent   = var.assured_workloads.folder
  name     = "${var.assured_workloads.regime} ${each.key}"
  iam      = local._envs_folder_iam
  tag_bindings = {
    context = try(
      module.organization.tag_values["${var.tag_names.context}/envs"].id, null
    )
  }
}

module "branch-envs-sa" {
  source       = "../../../modules/iam-service-account"
  count        = var.fast_features.envs ? 1 : 0
  project_id   = var.automation.project_id
  name         = "prod-resman-envs-0"
  display_name = "Terraform resman envs service account."
  prefix       = var.prefix
  iam_project_roles = {
    (var.automation.project_id) = ["roles/serviceusage.serviceUsageConsumer"]
  }
  iam_storage_roles = {
    (var.automation.outputs_bucket) = ["roles/storage.objectAdmin"]
  }
}

module "env-host-projects" {
  source          = "../../../modules/project"
  for_each        = var.envs_folders
  billing_account = var.billing_account.id
  name            = lower("${each.key}-host-project-0")
  parent          = module.branch-envs-folders[each.key].id
  prefix          = var.prefix
  services = [
    "accesscontextmanager.googleapis.com",
    "bigquery.googleapis.com",
    "bigqueryreservation.googleapis.com",
    "bigquerystorage.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "essentialcontacts.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "orgpolicy.googleapis.com",
    "pubsub.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "stackdriver.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com",
    "sts.googleapis.com"
  ]
}