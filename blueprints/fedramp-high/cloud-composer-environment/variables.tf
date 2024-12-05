
variable "composer_env_name" {
  description = "Name of the Composer environment."
  type        = string
}

variable "composer_version" {
  description = "Cloud composer version."
  type        = string
  default     = "composer-3-airflow-2" # As of 4 DEC 2024 only Cloud Composer 3 supports private IPs
}

variable "landing_project_id" {
  description = "The ID of the landing zone project where the VPC is."
  type        = string
}

variable "network" {
  description = "Full path to VPC."
  type        = string
}

variable "project_id" {
  description = "Project id."
  type        = string
}

variable "region" {
  description = "Region to deploy Cloud Composer into."
  type        = string
}

variable "sa_account_id" {
  description = "Service account id."
  default     = "composer-env-account"
  type        = string
}

variable "sa_display_name" {
  description = "Service account display name."
  default     = "Service Account for Composer Environment"
  type        = string
}

variable "service_agent_version" {
  description = "Composer Service Agent version. This must correspond to Composer version."
  type        = string
  default     = "roles/composer.ServiceAgentV2Ext"
}

variable "subnet" {
  description = "Full path to subnetwork."
  type        = string
}