variable "iam" {
  description = "IAM bindings in {SECRET => {ROLE => [MEMBERS]}} format."
  type        = map(map(list(string)))
  default     = {}
}

variable "main_project_id" {
  description = "The Google Cloud Project ID where the secrets will be created."
  type        = string
}

variable "gcp_region" {
  description = "The Google Cloud region to be used as the default for regional resources and the provider. Note: Secret Manager secrets are regional resources."
  type        = string
  default     = "us-east4"
}

variable "secrets" {
  description = "Map of secret configurations. Each key is the `secret_id` (name) of the secret. Each value is an object with optional `expire_time`, `version_destroy_ttl`, `locations` (list of regions for user-managed replication), and `keys` (a map where keys are replication locations (or 'global') and values are full KMS CryptoKey self-links for encryption)." # Clarified description
  type = map(object({
    location            = string # A location is required for every secret
    key                 = string # A key is required for the location (the key and secret must be in the same region)
    expire_time         = optional(string)
    version_destroy_ttl = optional(string)
  }))
  default = {}
}

variable "core_project_id" {
  description = "The Google Cloud Project ID where shared core services like KMS keys are located. Used for referencing existing KMS keys."
  type        = string
}

