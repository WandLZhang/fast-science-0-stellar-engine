Copyright 2023 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

1. The Principal (user or group) must have Cloud KMS Admin permission at the GCP Level
1. [Enable Dataflow API](https://console.developers.google.com/apis/api/dataflow.googleapis.com/overview)

## Deployment Steps
1. Update the variables in terraform.tfvars
1. Run the following Terraform commands and type "yes" when prompted

```bash
terraform init
terraform plan
terraform apply
```

Note: If you are using a KMS keyring that already exists, you must import it as documented [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring)
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [allowed_source_ranges](variables.tf#L23) | These are the allowed source ranges. | <code>list&#40;string&#41;</code> | ✓ |  |
| [bucket_name](variables.tf#L28) | This is the name of the bucket. | <code>string</code> | ✓ |  |
| [dataflow_name](variables.tf#L33) | Name of the Dataflow project. | <code>string</code> | ✓ |  |
| [firewall_name](variables.tf#L38) | The firewall name. | <code>string</code> | ✓ |  |
| [ip_cidr_range](variables.tf#L43) | IP CIDR Range for DataFlow subnet. | <code>string</code> | ✓ |  |
| [kms_key_names](variables.tf#L48) | Key names and base attributes. Set attributes to null if not needed. | <code title="map&#40;object&#40;&#123;&#10;  destroy_scheduled_duration    &#61; optional&#40;string&#41;&#10;  rotation_period               &#61; optional&#40;string, &#34;7776000s&#34;&#41; &#35; CIS Compliance Benchmark 1.10&#10;  labels                        &#61; optional&#40;map&#40;string&#41;&#41;&#10;  purpose                       &#61; optional&#40;string, &#34;ENCRYPT_DECRYPT&#34;&#41;&#10;  skip_initial_version_creation &#61; optional&#40;bool, false&#41;&#10;  version_template &#61; optional&#40;object&#40;&#123;&#10;    algorithm        &#61; string&#10;    protection_level &#61; optional&#40;string, &#34;HSM&#34;&#41;&#10;  &#125;&#41;&#41;&#10;&#10;&#10;  iam &#61; optional&#40;map&#40;list&#40;string&#41;&#41;, &#123;&#125;&#41;&#10;  iam_bindings &#61; optional&#40;map&#40;object&#40;&#123;&#10;    members &#61; list&#40;string&#41;&#10;    role    &#61; string&#10;    condition &#61; optional&#40;object&#40;&#123;&#10;      expression  &#61; string&#10;      title       &#61; string&#10;      description &#61; optional&#40;string&#41;&#10;    &#125;&#41;&#41;&#10;  &#125;&#41;&#41;, &#123;&#125;&#41;&#10;  iam_bindings_additive &#61; optional&#40;map&#40;object&#40;&#123;&#10;    member &#61; string&#10;    role   &#61; string&#10;    condition &#61; optional&#40;object&#40;&#123;&#10;      expression  &#61; string&#10;      title       &#61; string&#10;      description &#61; optional&#40;string&#41;&#10;    &#125;&#41;&#41;&#10;  &#125;&#41;&#41;, &#123;&#125;&#41;&#10;&#125;&#41;&#41;">map&#40;object&#40;&#123;&#8230;&#125;&#41;&#41;</code> | ✓ |  |
| [kms_keyring_name](variables.tf#L83) | Keyring attributes. | <code title="object&#40;&#123;&#10;  location &#61; string&#10;  name     &#61; string&#10;&#125;&#41;">object&#40;&#123;&#8230;&#125;&#41;</code> | ✓ |  |
| [main_project_id](variables.tf#L91) | The ID of the project in which to provision resources. | <code>string</code> | ✓ |  |
| [network_name](variables.tf#L96) | The network name. | <code>string</code> | ✓ |  |
| [network_project_id](variables.tf#L101) | Project that the Compute Engine VPC is located. | <code>string</code> | ✓ |  |
| [parameters](variables.tf#L106) | Daraflow Paramaters. | <code>map&#40;string&#41;</code> | ✓ |  |
| [prefix](variables.tf#L111) | This is the prefix for all resources. | <code>string</code> | ✓ |  |
| [storage_class](variables.tf#L122) | This is the storage class of the storage bucket. | <code>string</code> | ✓ |  |
| [subnetwork_name](variables.tf#L127) | The subnet name. | <code>string</code> | ✓ |  |
| [template_gcs_path](variables.tf#L132) | This is the template path of the dataflow job. | <code>string</code> | ✓ |  |
| [allowed_firewall_ports](variables.tf#L17) | The allowed ports for the firewall. Dataflow requires 12345 and 12346. | <code>list&#40;string&#41;</code> |  | <code>&#91;12345, 12346&#93;</code> |
| [region](variables.tf#L116) | The region in which to provision resources. | <code>string</code> |  | <code>&#34;us-east4&#34;</code> |
| [zone](variables.tf#L137) | This is the name of the zone. | <code>string</code> |  | <code>&#34;us-east4&#34;</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [dataflow-job](outputs.tf#L1) | Dataflow job. |  |
| [gcs-bucket](outputs.tf#L6) | GCS Bucket. |  |
<!-- END TFDOC -->
