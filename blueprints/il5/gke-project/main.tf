provider "google" {
  project = var.project_id
  region  = var.region
}

# Custom service account with compute engine role  
resource "google_service_account" "compute" {
  account_id = var.compute_service_account_id
  project    = var.project_id
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
module "vpc" {
  source                  = "../../../modules/net-vpc"
  project_id              = var.project_id
  name                    = "vpc-gke-networkv2"
  auto_create_subnetworks = false
  subnets = [
    {
      ip_cidr_range = "10.0.1.0/24"
      name          = "subnet-a1"
      region        = var.region
      secondary_ip_ranges = {
        pods     = "172.16.0.0/20"
        services = "192.168.0.0/24"
      }
    }
  ]
}

module "nat" {
  source         = "../../../modules/net-cloudnat"
  project_id     = var.project_id
  region         = var.region
  name           = "dev-nat"
  router_network = module.vpc.name
}

module "cluster" {
  source     = "../../../modules/gke-cluster-standard"
  project_id = var.project_id
  name       = "cluster-1"
  location   = var.region
  vpc_config = {
    master_ipv4_cidr_block = "10.0.0.0/28"
    network                = module.vpc.self_link
    subnetwork             = module.vpc.subnet_self_links["${var.region}/subnet-a1"]
  }
  node_config = {
    boot_disk_kms_key = "projects/${var.project_id}/locations/${var.region}/keyRings/${var.keyring.name}/cryptoKeys/gke-keynamev2"
  }
  private_cluster_config = {
    enable_private_endpoint = false
    master_global_access    = false
  }
  deletion_protection = false
}

resource "google_kms_crypto_key_iam_binding" "gke_key_encrypter_decrypter" {
  crypto_key_id = "projects/${var.project_id}/locations/${var.region}/keyRings/${var.keyring.name}/cryptoKeys/gke-keynamev2"
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = [
    "serviceAccount:${var.email}",
    "user:${var.email}",
    "group:${var.group_email}",
    "serviceAccount:${google_service_account.compute.email}",
    "serviceAccount:service-${data.google_project.current.number}@compute-system.iam.gserviceaccount.com",

  ]
}

module "cluster_nodepool" {
  source       = "../../../modules/gke-nodepool"
  project_id   = var.project_id
  cluster_name = "cluster-1"
  location     = var.region
  name         = "nodepool-1"
  service_account = {
    create = true
  }
  node_count = { initial = 3 }
}