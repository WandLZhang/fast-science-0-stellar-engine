variable "backup_schedule" {
  description = "Backup schedule."
  type = object({
    retention         = string
    daily_recurrence  = optional(bool, false)
    weekly_recurrence = optional(string)
  })
  default = null
}

variable "firestore_database_name" {
  type        = string
  description = "The name of the Firestore database instance."
}

variable "kms_key_name" {
  type        = string
  description = "The KMS key name used to encrypt the Firestore database."
  default     = null
}

variable "main_project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
}

variable "region" {
  type        = string
  description = "The location ID where the Firestore database will be created."
}