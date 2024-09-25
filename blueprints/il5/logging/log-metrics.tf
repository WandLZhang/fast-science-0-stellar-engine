resource "time_sleep" "wait_10_seconds" {
  depends_on = [
    google_logging_metric.owner_log,
    google_logging_metric.audit_config_change,
    google_logging_metric.custom_role_change,
    google_logging_metric.vpc_firewall_change,
    google_logging_metric.vpc_route_change,
    google_logging_metric.vpc_network_change,
    google_logging_metric.storage_iam_change,
    google_logging_metric.sql_config_change
  ]

  create_duration = "10s"
}
# CIS Compliance Benchmark 2.4
resource "google_logging_metric" "owner_log" {
  project     = var.project_id
  name        = "project-owner-log"
  filter      = <<EOH
  (protoPayload.serviceName="cloudresourcemanager.googleapis.com") 
  AND (ProjectOwnership OR projectOwnerInvitee) 
  OR (protoPayload.serviceData.policyDelta.bindingDeltas.action="REMOVE" 
  AND protoPayload.serviceData.policyDelta.bindingDeltas.role="roles/owner") 
  OR (protoPayload.serviceData.policyDelta.bindingDeltas.action="ADD" 
  AND protoPayload.serviceData.policyDelta.bindingDeltas.role="roles/owner")
  EOH
  description = "IAM Owner Log"
}

# CIS Compliance Benchmark 2.4
resource "google_monitoring_alert_policy" "owner_log_alert_policy" {
  project      = var.project_id
  display_name = "Owner Log Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "Owner Log Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/project-owner-log\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.owner_log, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.5
resource "google_logging_metric" "audit_config_change" {
  project     = var.project_id
  name        = "audit-config-change"
  filter      = <<EOH
  protoPayload.methodName="SetIamPolicy" 
  AND protoPayload.serviceData.policyDelta.auditConfigDeltas:*
  EOH
  description = "Audit config change"
}

# CIS Compliance Benchmark 2.5
resource "google_monitoring_alert_policy" "audit_config_alert_policy" {
  project      = var.project_id
  display_name = "Audit Config Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "Audit Config Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/audit-config-change\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.audit_config_change, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.6
resource "google_logging_metric" "custom_role_change" {
  project     = var.project_id
  name        = "custom-role-change"
  filter      = <<EOH
  resource.type="iam_role" 
  AND (protoPayload.methodName="google.iam.admin.v1.CreateRole" 
  OR protoPayload.methodName="google.iam.admin.v1.DeleteRole" 
  OR protoPayload.methodName="google.iam.admin.v1.UpdateRole")
  EOH
  description = "Custom role change"
}

# CIS Compliance Benchmark 2.6
resource "google_monitoring_alert_policy" "custom_role_alert_policy" {
  project      = var.project_id
  display_name = "Custom Role Change Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "Custom Role Change Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/custom-role-change\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.custom_role_change, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.7
resource "google_logging_metric" "vpc_firewall_change" {
  project     = var.project_id
  name        = "vpc-firewall-change"
  filter      = <<EOH
  resource.type="gce_firewall_rule" 
  AND (protoPayload.methodName:"compute.firewalls.patch" 
  OR protoPayload.methodName:"compute.firewalls.insert" 
  OR protoPayload.methodName:"compute.firewalls.delete")
  EOH
  description = "VPC Firewall Change"
}

# CIS Compliance Benchmark 2.7
resource "google_monitoring_alert_policy" "vpc_firewall_alert_policy" {
  project      = var.project_id
  display_name = "VPC Firewall Change Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "VPC Firewall Change Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-firewall-change\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.vpc_firewall_change, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.8
resource "google_logging_metric" "vpc_route_change" {
  project     = var.project_id
  name        = "vpc-route-change"
  filter      = <<EOH
  resource.type="gce_route" 
  AND (protoPayload.methodName:"compute.routes.delete" 
  OR protoPayload.methodName:"compute.routes.insert")
  EOH
  description = "VPC Route Change"
}

# CIS Compliance Benchmark 2.8
resource "google_monitoring_alert_policy" "vpc_route_alert_policy" {
  project      = var.project_id
  display_name = "VPC Route Change Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "VPC Route Change Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-route-change\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.vpc_route_change, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.9
resource "google_logging_metric" "vpc_network_change" {
  project     = var.project_id
  name        = "vpc-network-change"
  filter      = <<EOH
  resource.type="gce_network" 
  AND (protoPayload.methodName:"compute.networks.insert" 
  OR protoPayload.methodName:"compute.networks.patch" 
  OR protoPayload.methodName:"compute.networks.delete" 
  OR protoPayload.methodName:"compute.networks.removePeering"
  OR protoPayload.methodName:"compute.networks.addPeering")
  EOH
  description = "VPC Network Change"
}

# CIS Compliance Benchmark 2.9
resource "google_monitoring_alert_policy" "vpc_network_change_alert_policy" {
  project      = var.project_id
  display_name = "VPC Network Change Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Change Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-network-change\" AND resource.type=\"gce_network\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.vpc_network_change, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.10
resource "google_logging_metric" "storage_iam_change" {
  project     = var.project_id
  name        = "storage-iam-change"
  filter      = <<EOH
  resource.type="gcs_bucket" 
  AND protoPayload.methodName="storage.setIamPermissions"
  EOH
  description = "Storage IAM Change"
}

# CIS Compliance Benchmark 2.10
resource "google_monitoring_alert_policy" "storage_iam_change_alert_policy" {
  project      = var.project_id
  display_name = "Storage IAM Change Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "Storage IAM Change Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/storage-iam-change\" AND resource.type=\"gcs_bucket\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.storage_iam_change, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.11
resource "google_logging_metric" "sql_config_change" {
  project     = var.project_id
  name        = "sql-config-change"
  filter      = "protoPayload.methodName=\"cloudsql.instances.update\""
  description = "SQL Instance Config Change"
}

# CIS Compliance Benchmark 2.11
resource "google_monitoring_alert_policy" "sql_config_change_alert_policy" {
  project      = var.project_id
  display_name = "SQL Instance Config Change Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "SQL Instance Config Change Alert Policy"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/sql-config-change\" AND resource.type=\"global\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  depends_on = [google_logging_metric.sql_config_change, time_sleep.wait_10_seconds]
}

# CIS Compliance Benchmark 2.12
resource "google_logging_metric" "dns_logging" {
  project     = var.project_id
  name        = "dns-logging"
  filter      = <<EOH
  gcloud compute networks list --format="table[box,title='All VPC Networks'](name:label='VPC Network Name')"
  EOH
  description = "Cloud DNS Logging"
}
