# CIS Compliance Benchmark 2.1
resource "google_organization_iam_audit_config" "organization" {
  org_id  = var.organization.id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
}
