/**
 * Copyright 2023 Google LLC
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

data "google_project" "current" {}

# Only uncomment if no organization policies enforce the below
# resource "google_compute_project_metadata" "default" {
#   metadata = {
# enable-oslogin = "TRUE" # CIS Compliance Benchmark 4.4 - applies to all VMs in project
# enable-osconfig = "TRUE" # CIS Compliance Benchmark 4.12 - applies to all VMs in project
#   }
# }

resource "google_service_account" "gke" {
  account_id = "gke-${var.main_project_id}"
  project    = var.main_project_id
}

resource "google_project_iam_member" "gke_cluster_admin" {
  project = data.google_project.current.project_id
  role    = "roles/container.developer"
  member  = "serviceAccount:${data.google_project.current.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_service" "storagetransfer_api" {
  project = var.main_project_id
  service = "storagetransfer.googleapis.com"
}

resource "google_gke_hub_feature" "policycontroller" {
  name     = "policycontroller"
  location = "global"
  project  = var.main_project_id

  fleet_default_member_config {
    policycontroller {
      policy_controller_hub_config {
        install_spec              = "INSTALL_SPEC_ENABLED"
        referential_rules_enabled = true
        audit_interval_seconds    = 60
        policy_content {
          bundles {
            bundle              = "nist-sp-800-53-r5"
            exempted_namespaces = var.policy_controller_exemptable_namespaces
          }
          bundles {
            bundle              = "cis-k8s-v1.5.1"
            exempted_namespaces = var.policy_controller_exemptable_namespaces
          }
          bundles {
            bundle              = "nsa-cisa-k8s-v1.2"
            exempted_namespaces = var.policy_controller_exemptable_namespaces
          }
          template_library {
            installation = "ALL"
          }
        }
      }
    }
  }
}

module "kms" {
  source     = "../../../modules/kms"
  project_id = var.main_project_id
  keys       = var.kms_key_names
  keyring    = var.kms_keyring_name
  iam = {
    "roles/cloudkms.cryptoKeyEncrypterDecrypter" = [
      google_service_account.gke.member,
      "serviceAccount:${data.google_project.current.number}-compute@developer.gserviceaccount.com",
      "serviceAccount:service-${data.google_project.current.number}@gs-project-accounts.iam.gserviceaccount.com",
      "serviceAccount:service-${data.google_project.current.number}@compute-system.iam.gserviceaccount.com"
    ]
  }
}

module "vpc" {
  source                  = "../../../modules/net-vpc"
  project_id              = var.main_project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  subnets = [
    {
      ip_cidr_range = var.subnetwork_ip_cidr_range_1
      name          = var.subnetwork_name
      region        = var.region
      secondary_ip_ranges = {
        pods     = var.subnetwork_secondary_ip_range_pods_1
        services = var.subnetwork_secondary_ip_range_services_1
      }
      # CIS Compliance Benchmark 3.8
      flow_logs_config = {
        aggregation_interval = "INTERVAL_5_SEC"
        flow_sampling        = 1.0
        metadata             = "INCLUDE_ALL_METADATA"
        filter_expression    = "true"
      }
    }
  ]
  dns_policy = {
    logging = true # CIS Compliance Benchmark 2.12
  }
}

module "cluster" {
  source              = "../../../modules/gke-cluster-standard-se"
  project_id          = var.main_project_id
  name                = var.gke_cluster_name
  location            = var.region
  deletion_protection = false
  vpc_config = {
    master_ipv4_cidr_block = var.gke_vpc_master_ipv4_cidr_block
    network                = module.vpc.self_link
    subnetwork             = module.vpc.subnet_self_links["${var.region}/${var.subnetwork_name}"]
    master_authorized_ranges = {
      internal-vms = var.master_authorized_ranges_ip_ranges
    }
  }
  default_nodepool = {
    initial_node_count       = var.gke_initial_node_per_zone
    remove_pool              = false
    remove_default_node_pool = false
  }
  node_config = {
    # CIS Compliance Benchmark 4.3
    metadata = {
      block-project-ssh-keys = true
    }
    boot_disk_kms_key = module.kms.keys.default.id

    # CIS Compliance Benchmark 4.1
    # CIS Compliance Benchmark 4.2
    service_account = google_service_account.gke.email

    tags = var.node_config_tags

    machine_type = "n2d-standard-2"
    confidential_nodes = {
      enabled = true # CIS Compliance Benchmark 4.11 - Must also choose compatible instance type
    }
  }
  enable_features = {
    enable_shielded_nodes = true
    dataplane_v2          = true
    binary_authorization  = true
  }
  private_cluster_config = {
    enable_private_endpoint = var.gke_cluster_enable_private_endpoint
    master_global_access    = var.gke_cluster_master_global_access
  }
  depends_on = [module.vpc, module.kms]
}

module "cluster_nodepool" {
  source       = "../../../modules/gke-nodepool"
  project_id   = var.main_project_id
  cluster_name = var.gke_cluster_name
  location     = var.region
  name         = var.gke_nodepool_name
  node_count   = var.nodepool_node_count

  # CIS Compliance Benchmark 4.1
  # CIS Compliance Benchmark 4.2
  service_account = {
    email = google_service_account.gke.email
  }
  node_config = {
    boot_disk_kms_key = module.kms.keys.default.id
    disk_size_gb      = var.node_disk_size_gb
    machine_type      = var.node_machine_type
    shielded_instance_config = {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
  depends_on = [module.cluster]
}

module "bucket" {
  source         = "../../../modules/gcs"
  project_id     = var.main_project_id
  name           = var.bucket_name
  location       = var.region
  encryption_key = module.kms.keys.default.id
  objects_to_upload = merge(
    tomap({
      for file in fileset("./policies/templates", "*.yaml") :
      file => {
        name         = "policies/templates/${file}"
        source       = "./policies/templates/${file}"
        content_type = "application/x-yaml"
      }
    }),
    tomap({
      for file in fileset("./policies/constraints", "*.yaml") :
      file => {
        name         = "policies/constraints/${file}"
        source       = "./policies/constraints/${file}"
        content_type = "application/x-yaml"
      }
    }),
    tomap({
      for file in fileset("./scripts", "*.sh") :
      file => {
        name         = "scripts/${file}"
        source       = "./scripts/${file}"
        content_type = "application/x-sh"
      }
  }))
  iam = {
    "roles/storage.objectUser" = [
      google_service_account.gke.member,
      "serviceAccount:${data.google_project.current.number}-compute@developer.gserviceaccount.com",
      "serviceAccount:service-${data.google_project.current.number}@gs-project-accounts.iam.gserviceaccount.com",
      "serviceAccount:service-${data.google_project.current.number}@compute-system.iam.gserviceaccount.com"
    ]
  }
}

module "compute-vm" {
  source        = "../../../modules/compute-vm"
  name          = "bastion-vm"
  project_id    = var.main_project_id
  zone          = "us-east4-a"
  instance_type = "e2-medium"
  service_account = {
    scopes = ["cloud-platform"]
  }
  boot_disk = {
    initialize_params = {
      image_project = "debian-cloud"
      image_family  = "debian-11"
    }
  }
  network_interfaces = [
    {
      network    = "projects/${var.main_project_id}/global/networks/${var.network_name}"
      subnetwork = "projects/${var.main_project_id}/regions/${var.region}/subnetworks/${var.subnetwork_name}"
    }
  ]
  tags = ["allow-iap", "allow-local-connect"]
  metadata = {
    startup-script = <<-EOT
#!/bin/bash
set -eou pipefail
exec > >(tee -ia /tmp/bastion_script.log) 2>&1
echo "Startup Script..."
GCS_BUCKET=${var.bucket_name}
LOCAL_SCRIPTS_DIR="/tmp/gcs-script-files"
LOCAL_TEMPLATES_DIR="/tmp/gcs-policy-files/templates"
LOCAL_CONSTRAINTS_DIR="/tmp/gcs-policy-files/constraints"
mkdir -p "$LOCAL_SCRIPTS_DIR"
mkdir -p "$LOCAL_TEMPLATES_DIR"
mkdir -p "$LOCAL_CONSTRAINTS_DIR"

# Install gcloud CLI and kubectl
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update -y
sudo apt-get install google-cloud-sdk kubectl -y
sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin

FILES=$(gsutil ls gs://$GCS_BUCKET/scripts/*.sh)
echo $FILES

for FILE in $FILES; do
  FILENAME=$(basename $FILE)
  LOCAL_PATH="$LOCAL_SCRIPTS_DIR/$FILENAME"
  echo "Downloading $FILENAME..."
  gsutil cp $FILE $LOCAL_PATH
  chmod +x $LOCAL_PATH
done

TEMPLATES=$(gsutil ls gs://$GCS_BUCKET/policies/templates/*.yaml)
echo $TEMPLATES

for FILE in $TEMPLATES; do
  FILENAME=$(basename $FILE)
  LOCAL_PATH="$LOCAL_TEMPLATES_DIR/$FILENAME"
  echo "Downloading $FILENAME..."
  gsutil cp $FILE $LOCAL_PATH
done

CONSTRAINTS=$(gsutil ls gs://$GCS_BUCKET/policies/constraints/*.yaml)
echo $CONSTRAINTS

for FILE in $CONSTRAINTS; do
  FILENAME=$(basename $FILE)
  LOCAL_PATH="$LOCAL_CONSTRAINTS_DIR/$FILENAME"
  echo "Downloading $FILENAME..."
  gsutil cp $FILE $LOCAL_PATH
done
EOT
  }
  encryption = {
    kms_key_self_link = module.kms.keys.default.id
  }
  depends_on = [module.bucket, module.cluster]
}

resource "google_compute_firewall" "allow-iap" {
  name          = "${var.network_name}-allow-iap"
  description   = "Allow IAP for connecting to GKE from bastion host."
  network       = var.network_name
  project       = var.main_project_id
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "TCP"
    ports    = ["22"]
  }
  target_tags = ["allow-iap"]
  depends_on  = [module.vpc]
}

resource "google_compute_firewall" "allow-local-connect" {
  count         = var.local_admin_external_ip != null ? 1 : 0
  name          = "${var.network_name}-allow-local-connect"
  description   = "Allow for connecting to bastion host from local system."
  network       = var.network_name
  project       = var.main_project_id
  source_ranges = var.local_admin_external_ip
  allow {
    protocol = "TCP"
    ports    = ["22"]
  }
  target_tags = ["allow-local-connect"]
  depends_on  = [module.vpc]
}