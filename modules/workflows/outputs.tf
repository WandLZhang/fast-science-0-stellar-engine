output "service_account" {
  description = "The workflow service account."
  value       = var.service_account
}

output "workflow" {
  description = "The newly created workflow."
  value       = google_workflows_workflow.default
}