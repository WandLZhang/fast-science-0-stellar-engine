variable "project_id" {
  description = "The ID of the project in which to create the GKE cluster."
  type        = string
  default     = "tnbsea-dev-tapand-dev"
}

variable "email" {
  description = "Email address of the user."
  type        = string
  default     = "admin.tapan@dino-runner.darkwolfsolutions.com"
}

variable "group_email" {
  description = "Email address of the group."
  type        = string
  default     = "gcp-devops@dino-runner.darkwolfsolutions.com"
}

variable "region" {
  description = "The GCP region to use for the resources."
  type        = string
  default     = "us-east4"
}

variable "compute_service_account_id" {
  description = "The Compute Enginer Service account"
  type        = string
  default     = "gke-compute-sa"
}


variable "node_config" {
  description = "Node-level configuration."
  type = object({
    boot_disk_kms_key = optional(string)
    service_account   = optional(string)
    tags              = optional(list(string))
  })
  default = {
    boot_disk_kms_key = "projects/tnbsea-dev-tapand-dev/locations/us-east4/keyRings/gke-keyringv2/cryptoKeys/gke-keynamev2"
  }
}

variable "keyring" {
  description = "Keyring attributes."
  type = object({
    location = string
    name     = string
  })
  default = {
    location = "us-east4"
    name     = "gke-keyringv2"
  }
}

variable "default_nodepool" {
  description = "Enable default nodepool."
  type = object({
    remove_pool        = optional(bool, true)
    initial_node_count = optional(number, 1)
  })
  default = {
    remove_pool        = false
    initial_node_count = 1
  }
  nullable = false
  validation {
    condition = (
      var.default_nodepool.remove_pool != true
      ||
      var.default_nodepool.initial_node_count != null
    )
    error_message = "If `remove_pool` is set to false, `initial_node_count` needs to be set."
  }
}
variable "keys" {
  description = "Key names and base attributes. Set attributes to null if not needed."
  type = map(object({
    destroy_scheduled_duration    = optional(string)
    rotation_period               = optional(string)
    labels                        = optional(map(string))
    purpose                       = optional(string, "ENCRYPT_DECRYPT")
    skip_initial_version_creation = optional(bool, false)
    version_template = optional(object({
      algorithm        = string
      protection_level = optional(string, "SOFTWARE")
    }))
    iam = optional(map(list(string)), {})
    iam_bindings = optional(map(object({
      members = list(string)
      role    = string
      condition = optional(object({
        expression  = string
        title       = string
        description = optional(string)
      }))
    })), {})
    iam_bindings_additive = optional(map(object({
      member = string
      role   = string
      condition = optional(object({
        expression  = string
        title       = string
        description = optional(string)
      }))
    })), {})
  }))
  default = {
    "gke-keynamev2" = {
      rotation_period            = "7776000s"
      destroy_scheduled_duration = "2592000s"
      labels = {
        team = "gke-team"
      }
      version_template = {
        algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
        protection_level = "SOFTWARE"
      }
      iam = {
        "roles/cloudkms.cryptoKeyEncrypterDecrypter" = ["user:admin.tapan@dino-runner.darkwolfsolutions.com", "group:gcp-devops@dino-runner.darkwolfsolutions.com"]
      }
      lifecycle = {
        prevent_destroy = true
      }
    }
  }
  nullable = false
}
variable "deletion_protection" {
  description = "Prevent Terraform from destroying data storage resources (storage buckets, GKE clusters, CloudSQL instances) in this blueprint. When this field is set in Terraform state, a terraform destroy or terraform apply that would delete data storage resources will fail."
  type        = bool
  default     = false
  nullable    = false
}
