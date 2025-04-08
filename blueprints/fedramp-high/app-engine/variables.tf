variable "main_project_id" {
  description = "Main Project ID to host App Engine. App Engine cannot be delete from the project once provisioned."
  type        = string
}

variable "region" {
  description = "Region to create your App Engine resource."
  type        = string
}
