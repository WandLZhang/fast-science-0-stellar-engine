output "access_levels" {
  description = "The list of created access levels."
  value = {
    for access_level in google_access_context_manager_access_level.access_levels : access_level.name => {
      id          = access_level.id
      name        = access_level.name
      description = access_level.description
    }
  }
}

output "service_perimeters" {
  description = "The list of created service perimeters."
  value = {
    for perimeter in google_access_context_manager_service_perimeter.service_perimeters : perimeter.name => {
      id          = perimeter.id
      name        = perimeter.name
      description = perimeter.description
    }
  }
}