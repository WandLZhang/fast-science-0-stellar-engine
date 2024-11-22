variable "description" {
  description = "Description of the workflow."
  type        = string
  default     = null
}

variable "env_vars" {
  description = "Environment variables made available to your workflow execution."
  type        = map(string)
  default     = null
}

variable "file" {
  description = "File path to the instructions for the workflow."
  type        = string
}

variable "iam" {
  description = "IAM bindings in {KEY => {role = ROLE, members = [], condition = {}}}. Keys are arbitrary."
  type = map(object({
    member = string
    role   = string
    condition = optional(object({
      expression  = string
      title       = string
      description = optional(string)
    }))
  }))
  nullable = false
  default  = {}
}

variable "key" {
  description = "The CMEK used to encrypt the workflow."
  type        = string
}

variable "logging_level" {
  description = "Logging level of workflow executions."
  type        = string
  default     = "LOG_ERRORS_ONLY"
}

variable "name" {
  description = "Name of the workflow."
  type        = string
}

variable "project" {
  description = "The Google Project ID."
  type        = string
}

variable "region" {
  description = "The Google Cloud region."
  type        = string
}

variable "service_account" {
  description = "Service account for Wokflow."
  type        = string
}