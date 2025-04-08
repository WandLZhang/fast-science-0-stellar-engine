# Cloud Composer
This blueprint deploys a Cloud Composer environment.

<!-- BEGIN TOC -->
- [Prerequisites](#prerequisites)
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->

## Prerequisites
1. Service Account User role (roles/iam.serviceAccountUser) for deploying user
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [composer_env_name](variables.tf#L2) | Name of the Composer environment. | <code>string</code> | ✓ |  |
| [main_project_id](variables.tf#L13) | Project id. | <code>string</code> | ✓ |  |
| [network_name](variables.tf#L18) | Full path to VPC. | <code>string</code> | ✓ |  |
| [network_project_id](variables.tf#L23) | The ID of the landing zone project where the VPC is. | <code>string</code> | ✓ |  |
| [region](variables.tf#L28) | Region to deploy Cloud Composer into. | <code>string</code> | ✓ |  |
| [subnetwork_name](variables.tf#L51) | Full path to subnetwork. | <code>string</code> | ✓ |  |
| [composer_version](variables.tf#L7) | Cloud composer version. | <code>string</code> |  | <code>&#34;composer-3-airflow-2&#34; &#35; As of 4 DEC 2024 only Cloud Composer 3 supports private IPs&#34;</code> |
| [sa_account_id](variables.tf#L33) | Service account id. | <code>string</code> |  | <code>&#34;composer-env-account&#34;</code> |
| [sa_display_name](variables.tf#L39) | Service account display name. | <code>string</code> |  | <code>&#34;Service Account for Composer Environment&#34;</code> |
| [service_agent_version](variables.tf#L45) | Composer Service Agent version. This must correspond to Composer version. | <code>string</code> |  | <code>&#34;roles&#47;composer.ServiceAgentV2Ext&#34;</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [airflow_uri](outputs.tf#L1) | URI for Airflow. |  |
| [composer_id](outputs.tf#L6) | Cloud composer id. |  |
<!-- END TFDOC -->
