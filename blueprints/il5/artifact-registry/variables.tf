variable "kms_key_names" {
  description = "Key names and base attributes. Set attributes to null if not needed."
  type = map(object({
    destroy_scheduled_duration    = optional(string)
    rotation_period               = optional(string, "7776000s") # CIS Compliance Benchmark 1.10
    labels                        = optional(map(string))
    location                      = optional(string, "us-east4")
    purpose                       = optional(string, "ENCRYPT_DECRYPT")
    skip_initial_version_creation = optional(bool, false)
    version_template = optional(object({
      algorithm        = string
      protection_level = optional(string, "HSM")
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
    "artifact-registry" = {
      destroy_scheduled_duration    = null
      rotation_period               = null
      labels                        = null
      purpose                       = "ENCRYPT_DECRYPT"
      skip_initial_version_creation = false
      version_template = {
        algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
        protection_level = "HSM"
      }

      iam                   = {}
      iam_bindings          = {}
      iam_bindings_additive = {}
    }
  }

  nullable = false
}

variable "kms_keyring_name" {
  description = "Keyring attributes."
  type        = string
}

variable "main_project_id" {
  description = "GCP Project to deploy Google Artifact Registries into."
  type        = string

}

variable "network_name" {
  description = "VPC for deploying the compute VM which will access the registry."
  type        = string
  default     = ""
  nullable    = false
}

variable "network_project_id" {
  description = "Project that the Compute Engine VPC is located."
  type        = string
}

variable "region" {
  description = "GCP Region to deploy Google Artifact Registries into."
  type        = string
}

variable "subnetwork_name" {
  description = "VPC Subnet to deploy Google Artifact Registries into."
  type        = string
}