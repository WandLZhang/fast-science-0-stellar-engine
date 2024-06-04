/**
 * Copyright 2022 Google LLC
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

# tfdoc:file:description Project factory.

module "projects" {
  source = "../../../../modules/project-factory"
  data_defaults = {
    billing_account = var.billing_account.id
    # more defaults are available, check the project factory variables
    shared_vpc_service_config = {
      host_project = "tnbsea-prod-net-spoke-0"
    }
  }
  data_merges = {
    labels = {
      environment = "dev"
    }
    services = [
      "stackdriver.googleapis.com"
    ]
  }
  data_overrides = {
    prefix = "${var.prefix}-dev"
  }
  factories_config = var.factories_config
}


module "vpc" {
  source                          = "../../../../modules/net-vpc"
  project_id                      = var.project_id
  name                            = "vpc-app"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  routing_mode                    = "GLOBAL"
  subnets = [
    {
      name          = "subnet-app"
      region        = var.location
      ip_cidr_range = var.ip_cidr_range
    }
  ]

}

module "peering" {
  source        = "../../../..//modules/net-vpc-peering"
  prefix        = "app-prod-peer"
  local_network = module.vpc.self_link
  peer_network  = var.peer_network

}
 