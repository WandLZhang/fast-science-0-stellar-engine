data "google_storage_bucket" "terraform_state" {
  name = "${var.prefix}-gemini-enterprise-tf-state-${var.main_project_id}"
}
