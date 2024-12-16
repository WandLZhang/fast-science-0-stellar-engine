variable "description" {
  description = "Job description."
  type        = string
}

variable "http_target" {
  description = "HTTP Target for job."
  type = object({
    http_method = optional(string)
    uri         = optional(string)
    body        = optional(string)
    headers     = optional(map(string))
  })

  default = null
}

variable "kms_key" {
  description = "KMS key name."
  type        = string
  default     = null
}

variable "name" {
  description = "Job name."
  type        = string
}

variable "project_id" {
  description = "Project ID."
  type        = string
}

variable "pubsub_target" {
  description = "Pubsub target for job."
  type = object({
    topic_id   = optional(string)
    data       = optional(string)
    attributes = optional(map(string))
    new_topic = optional(object({
      create       = optional(bool)
      name         = optional(string)
      kms_key_name = optional(string)
    }))
  })

  default = {
    topic_id   = null
    data       = null
    new_topic  = null
    attributes = null
  }
}

variable "retry_config" {
  description = "Retry config."
  type = object({
    retry_count          = optional(number, null)
    max_retry_duration   = optional(string, null)
    min_backoff_duration = optional(string, null)
    max_backoff_duration = optional(string, null)
    max_doublings        = optional(number, null)
  })

  default = null
}

variable "schedule" {
  description = "Schedule to run job."
  type        = string

}

variable "trigger_type" {
  description = "Type of trigger for the function. Valid values are 'pubsub' or 'http'."
  type        = string
  validation {
    condition     = contains(["pubsub", "http"], var.trigger_type)
    error_message = "Valid values for trigger_type are 'pubsub' or 'http'."
  }
}