resource "google_project_iam_member" "bindings" {
  for_each = var.iam
  project  = var.project
  role     = each.value.role
  member   = each.value.member
  dynamic "condition" {
    for_each = each.value.condition == null ? [] : [""]
    content {
      expression  = each.value.condition.expression
      title       = each.value.condition.title
      description = each.value.condition.description
    }
  }
}