provider "googleworkspace" {
  customer_id = var.google_workspace_customer_id
  impersonated_user_email = "workspace-group-manager@apr24-test-test1-main-0.iam.gserviceaccount.com"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
  ]
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
  user_project_override = true
  billing_project = var.project_id
}
