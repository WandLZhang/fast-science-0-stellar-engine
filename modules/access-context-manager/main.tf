data "google_access_context_manager_access_policy" "policy" {
  parent = "organizations/${var.organization_id}"
}

resource "google_access_context_manager_access_level" "access_levels" {
  provider    =  google-beta
  for_each    = { for level in var.access_levels : level.name => level }

  parent      = "accessPolicies/${data.google_access_context_manager_access_policy.policy.id}"
  name        = each.value.name
  title       = each.value.name
  description = each.value.description

  basic {
    conditions {
      ip_subnetworks = each.value.conditions[0].ip_subnetworks
      members        = each.value.conditions[0].members
      negate         = each.value.conditions[0].negate
      device_policy {
        require_screen_lock = each.value.conditions[0].device_policy.require_screen_lock
      }
      regions = each.value.conditions[0].regions
    }
  }
}

resource "google_access_context_manager_service_perimeter" "service_perimeters" {
  for_each = { for perimeter in var.service_perimeters : perimeter.name => perimeter }

  parent      = "accessPolicies/${data.google_access_context_manager_access_policy.policy.id}"
  name        = each.value.name
  title       = each.value.name
  description = each.value.description

  status {
    restricted_services = each.value.status.restricted_services
    resources           = each.value.status.resources
  }
}