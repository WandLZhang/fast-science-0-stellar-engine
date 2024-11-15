variable "alert_email" {
  description = "Alert email."
  type        = string

}

variable "alignment_period" {
  description = "Alignment period."
  type        = string

}

variable "combiner" {
  description = "Combiner (AND/OR)."
  type        = string
}

variable "comparison" {
  description = "Comparison."
  type        = string
}

variable "duration" {
  description = "Duration for alert."
  type        = string
}

variable "per_series_aligner" {
  description = "Per series aligner."
  type        = string
}

variable "project" {
  description = "Project ID."
  type        = string
}