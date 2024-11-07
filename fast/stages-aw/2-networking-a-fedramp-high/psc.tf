module "private_service_connect" {
  source   = "../../../modules/private-service-connect"
  for_each = var.envs_folders

  project_id = module.env-spoke-projects[each.key].project_id

  network_self_link          = module.env-spoke-vpc[each.key].self_link
  private_service_connect_ip = "10.3.0.5"
  forwarding_rule_target     = "all-apis"
}