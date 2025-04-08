# Cloud Spanner
This blueprint deploys an Assured Workloads FedRAMP compliant Cloud Spanner instance.

<!-- BEGIN TOC -->
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [database_name](variables.tf#L8) | Database name. | <code>string</code> | ✓ |  |
| [database_user](variables.tf#L13) | Database user or group. Must start with \"user:\" or \"group:\" or \"serviceAccount:\". | <code>string</code> | ✓ |  |
| [display_name](variables.tf#L18) | Cloud spanner display name. | <code>string</code> | ✓ |  |
| [instance_name](variables.tf#L39) | Cloud spanner instance name. | <code>string</code> | ✓ |  |
| [main_project_id](variables.tf#L44) | Project to deploy Cloud Spanner instance. | <code>string</code> | ✓ |  |
| [config_name](variables.tf#L2) | Cloud spanner instance config name. | <code>string</code> |  | <code>&#34;regional-us-east4&#34;</code> |
| [edition](variables.tf#L23) | The Spanner instance edition. Valid values are 'EDITION_UNSPECIFIED', 'STANDARD', 'ENTERPRISE', or 'ENTERPRISE_PLUS'. | <code>string</code> |  | <code>&#34;ENTERPRISE&#34; &#35; ENTERPRISE is required for autoscaling&#34;</code> |
| [high_priority_cpu_utilization_percent](variables.tf#L33) | High priority cpu utilization percent. | <code>number</code> |  | <code>75</code> |
| [max_processing_units](variables.tf#L49) | Max processing units for autoscaling. | <code>number</code> |  | <code>3000</code> |
| [min_processing_units](variables.tf#L55) | Min processing units for autoscaling. | <code>number</code> |  | <code>2000</code> |
| [region](variables.tf#L61) | Region to create your App Engine resource. | <code>string</code> |  | <code>&#34;us-east4&#34;</code> |
| [storage_utilization_percent](variables.tf#L67) | Storage utilization percent. | <code>number</code> |  | <code>90</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [instance](outputs.tf#L1) | Cloud spanner instance. |  |
<!-- END TFDOC -->
