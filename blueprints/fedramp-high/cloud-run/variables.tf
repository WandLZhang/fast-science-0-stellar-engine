variable "container_image" {
  description = "Container image to be hosted on cloud run."
  type        = string
}

variable "cpu" {
  description = "Sets the CPU limit. 1000m = 1 vCPU."
  type        = string
  default     = "1000m"
}

variable "cpu_idle" {
  description = "Allows the container to scale to zero."
  type        = bool
  default     = true
}

variable "env_vars" {
  description = "Environment variables for the Cloud Run service or job."
  type        = map(string)
  default     = {}
}

variable "ingress" {
  description = "Ingress settings."
  type        = string
  default     = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
}

variable "is_job" {
  description = "Set to true to create a job instead of a service."
  type        = bool
  default     = false
}

variable "kms_key" {
  description = "Path to the kms key to use."
  type        = string
}

variable "memory" {
  description = "Sets the memory limit. 512Mi = 512MiB."
  type        = string
  default     = "512Mi"
}

variable "name" {
  description = "Name of the cloud run instance to be created."
  type        = string
}

variable "port" {
  description = "Mapping of port number and port name to open."
  type        = number
  default     = 8080
}

variable "project_id" {
  description = "The Project ID."
  type        = string
}

variable "region" {
  description = "Region that Project is in."
  type        = string
}
