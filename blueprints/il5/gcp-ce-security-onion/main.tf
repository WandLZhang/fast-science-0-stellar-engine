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

# Terraform Provider for Google Cloud Platform
provider "google" {
  project = var.project_id
  region  = var.location
}

# Work on the Current Project
data "google_project" "current" {}

# Custom service account with compute engine role  
resource "google_service_account" "compute" {
  account_id = var.compute_service_account_id
  project    = var.project_id
}


# Google Compute Engine VM Module

module "compute-engine-vm" {
  source        = "../../../modules/compute-vm"
  project_id    = var.project_id
  zone          = var.zone
  name          = var.instance_name
  instance_type = var.instance_type

  boot_disk = {
    initialize_params = {
      #image = "debian-cloud/debian-10"
      size = 200
      #image = "https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-7-v20240611"
      image = "ubuntu-2004-focal-v20240614" # Use an appropriate Ubuntu image
      type  = "pd-ssd"
    }
  }

  network_interfaces = [{
    network    = module.vpc.network.self_link
    subnetwork = "projects/${var.project_id}/regions/${var.location}/subnetworks/subnet-securityoniona"
  }]
  # Define metadata, including the startup script
  metadata = {
    startup-script = file("${path.module}/startup-script.sh")
  }
  tags = ["security-onion"]

  encryption = {
    #kms_key_self_link = module.kms.keys.key-so.id
    kms_key_self_link = "projects/${var.project_id}/locations/${var.location}/keyRings/${var.keyring.name}/cryptoKeys/key-so"
  }
  service_account = {
    email = google_service_account.compute.email
  }
  # Persistent Disk Attached to the Compute Engine with KMS
  attached_disks = [
    {
      auto_delete = var.auto_delete
      size        = 100
      name        = "data-disk"
      initialize_params = {
        #image = "debian-cloud/debian-10"
        image = "ubuntu-2004-focal-v20240614"
        #image = "https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-7-v20240611"
      }
      #kms_key_self_link = module.kms.keys.key-so.id
      kms_key_self_link = "projects/${var.project_id}/locations/${var.location}/keyRings/${var.keyring.name}/cryptoKeys/key-so"
    }
  ]

  #depends_on = [module.kms, google_service_account.compute]
  depends_on = [google_service_account.compute, module.vpc, module.nat]
}

# Google Cloud NAT Module - Simple Cloud NAT management
module "nat" {
  source         = "../../../modules/net-cloudnat"
  project_id     = var.project_id
  region         = var.location
  name           = "secutity-onion-nat"
  router_network = module.vpc.name

  #depends_on     = [module.vpc, module.kms]
  depends_on = [module.vpc]
}

# Google KMS Module
# module "kms" {
#   source     = "../../../modules/kms"
#   project_id = var.project_id
#   keys       = var.keys
#   iam = {
#     "roles/cloudkms.cryptoKeyEncrypterDecrypter" = [
#       google_service_account.compute.member,
#       "serviceAccount:service-${data.google_project.current.number}@compute-system.iam.gserviceaccount.com",
#       "user:${var.email}"
#     ]
#   }
#   keyring = var.keyring
# }

# Google VPC Module
module "vpc" {
  source                          = "../../../modules/net-vpc"
  project_id                      = var.project_id
  name                            = "vpc-securityoniona"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  routing_mode                    = "GLOBAL"
  subnets = [
    {
      name          = "subnet-securityoniona"
      region        = var.location
      ip_cidr_range = var.ip_cidr_range
    }
  ]
}

# Google Computer Firewall
resource "google_compute_firewall" "default" {
  name    = "allow-ssh-in"
  network = module.vpc.network.self_link
  allow {
    protocol = "all"
  }
  # Allowing to connect only within the VPC CIDR Range
  source_ranges = ["0.0.0.0/0"]
  target_tags   = []
  #source_ranges = var.source_ranges_allowed
}


# resource "google_compute_firewall" "allow-all-outbound" {
#   name    = "allow-all-outbound"
#   network = module.vpc.network.self_link  # Replace with your VPC name if different

#   allow {
#     protocol = "all"
#     ports    = []
#   }

#   source_ranges = ["0.0.0.0/0"]  # Allow traffic from all sources (any IP)
#   target_tags   = []             # No target tags (applies to all instances in the network)
# }
 