output "id" {
  description = "Job ID."
  value       = google_cloud_scheduler_job.job.id
}

output "state" {
  description = "Job state."
  value       = google_cloud_scheduler_job.job.state
}