provider "google" {
  project = var.project_id
  region  = var.region
}

# Create KMS Key Ring and Crypto Key using the kms module
module "kms" {
  source     = "../../../modules/kms"
  project_id = var.project_id
  keys       = var.keys
  keyring    = var.keyring
  iam = {
    "roles/cloudkms.cryptoKeyEncrypterDecrypter" = [
      "user:${var.email}",
      "group:${var.group_email}"
    ]
  }
}

# Google VPC Module
module "vpc" {
  source                  = "../../../modules/net-vpc"
  project_id              = var.project_id
  name                    = "vpc-gke-network"
  auto_create_subnetworks = false
  subnets = [
    {
      ip_cidr_range = "10.0.0.0/24"
      name          = "subnet-1"
      region        = var.region
      secondary_ip_range = {
        pods     = "10.1.0.0/16"
        services = "10.2.0.0/24"
      }
    }
  ]
}

# Wait for the VPC and subnets to be created before creating the cluster
resource "null_resource" "wait_for_vpc" {
  depends_on = [module.vpc]
  provisioner "local-exec" {
    command = "echo VPC and subnets are created."
  }
}

# Google GKE Cluster Module
module "cluster-1" {
  source     = "../../../modules/gke-cluster-standard"
  project_id = var.project_id
  name       = "cluster-1"
  location   = var.region
  vpc_config = {
    network    = module.vpc.self_link
    subnetwork = module.vpc.subnets["${var.region}/subnet-1"].self_link
    secondary_range_names = {
      pods     = "pods"
      services = "services"
    }
    master_authorized_ranges = {
      internal-vms = "10.0.0.0/8"
    }
    master_ipv4_cidr_block = "192.168.0.0/28"
  }
  node_config = {
    boot_disk_kms_key = "projects/${var.project_id}/locations/${var.region}/keyRings/${var.keyring.name}/cryptoKeys/gke-keyname"
  }
  max_pods_per_node = 32
  private_cluster_config = {
    enable_private_endpoint = true
    master_global_access    = false
  }
  labels = {
    environment = "dev"
  }
}

# Google GKE Node Pool Module
module "nodepool" {
  source       = "../../../modules/gke-nodepool"
  project_id   = var.project_id
  cluster_name = module.cluster-1.name
  location     = var.region
  name         = "nodepool-1"
}
