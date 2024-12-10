variable "create_topic" {
  description = "Set the name of the topic to create a pubsub topic."
  type = object({
    name = string
  })
  default = null
}

variable "data" {
  description = "Uneoncoded data to be sent."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of job."
  type        = string
}

variable "kms_key_name" {
  description = "Full path to KMS key for pubsub."
  type        = string
  default     = null
}

variable "max_backoff_duration" {
  description = "Max backoff duration."
  type        = string
  default     = null
}

variable "max_doublings" {
  description = "Max doublings."
  type        = number
  default     = null
}

variable "max_retry_duration" {
  description = "Maximum retry duration."
  type        = string
  default     = null
}

variable "min_backoff_duration" {
  description = "Minimum backoff duration."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the Cloud Scheduler job."
  type        = string
}

variable "new_topic_name" {
  description = "Name for new PubSub topic if creating one."
  type        = string
  default     = null
}

variable "project_id" {
  description = "Project id."
  type        = string
}

variable "region" {
  description = "Location to deploy job."
  type        = string
}

variable "retry_count" {
  description = "Number of retries."
  type        = number
  default     = null
}

variable "schedule" {
  description = "Schedule to implement the job -- use cron-based syntax."
  type        = string
}

variable "topic_id" {
  description = "PubSub topic ID."
  type        = string
  default     = null
}