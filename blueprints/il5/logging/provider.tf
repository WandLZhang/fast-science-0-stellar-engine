terraform {
  required_version = ">= 1.7.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.1.0, < 7.0.0" # tftest
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.1.0, < 7.0.0" # tftest
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.12.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
