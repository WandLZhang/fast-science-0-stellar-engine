resource "google_network_management_connectivity_test" "landing-test" {
  for_each = var.regions

  name    = "landing-subnet-test-${each.key}"
  project = module.vdss-host-project.project_id

  source {
    ip_address   = google_compute_address.source-addr[each.key].address
    project_id   = module.vdss-host-project.project_id
    network      = module.vdss-vpc.id
    network_type = "GCP_NETWORK"
  }
  destination {
    ip_address = "8.8.8.8"
    port       = 443
  }

  protocol = "TCP"
  labels = {
    env = "vdss"
  }
}

resource "google_compute_address" "source-addr" {
  project = module.vdss-host-project.project_id

  for_each     = var.regions
  name         = "landing-test-addr-${each.value}"
  subnetwork   = try(module.vdss-vpc.subnet_self_links["${each.value}/landing-default"], null)
  address_type = "INTERNAL"
  region       = each.value
}


resource "google_network_management_connectivity_test" "env-tests" {
  for_each = var.envs_folders

  name    = lower("${each.key}-host-project-test")
  project = module.env-spoke-projects[each.key].project_id

  source {
    ip_address   = google_compute_address.env-source-addrs[each.key].address
    project_id   = module.env-spoke-projects[each.key].project_id
    network      = module.env-spoke-vpc[each.key].id
    network_type = "GCP_NETWORK"
  }
  destination {
    ip_address = "8.8.8.8"
    port       = 443
  }

  protocol = "TCP"
  labels = {
    env = "vdss"
  }
}
resource "google_compute_address" "env-source-addrs" {
  for_each = var.envs_folders

  project = module.env-spoke-projects[each.key].project_id

  name         = lower("${each.key}-test-addr")
  subnetwork   = module.env-spoke-vpc[each.key].subnets[lower("${var.regions.primary}/${each.key}-default")].self_link
  address_type = "INTERNAL"
  region       = var.regions.primary
  depends_on = [ module.env-spoke-vpc ]
}