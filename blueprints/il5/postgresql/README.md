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
1. An existing VPC
1. Copy terraform.tfvars.sample to terraform.tfvars
1. Updated terraform.tfvars

## Notes
1. There seems to be a provider bug that will not allow a full terraform delete to complete due to the following error:

```
Unable to remove Service Networking Connection, err: Error waiting for Delete Service Networking Connection: Error code 9, message: Failed to delete connection; Producer services (e.g. CloudSQL, Cloud Memstore, etc.) are still using this connection.
```

To ensure proper deletion, please manually delete the peered network that is created, release the allocated ip address, and remove the following three services from the terraform state (terraform state rm <service-name>)
```
data.google_compute_network.network
google_compute_global_address.postgres
google_service_networking_connection.postgres
```

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | ../../../modules/kms | n/a |
| <a name="module_postgres"></a> [postgres](#module\_postgres) | ../../../modules/cloudsql-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.postgres](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_global_address.postgres](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_service_networking_connection.postgres](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_firewall_ports"></a> [allowed\_firewall\_ports](#input\_allowed\_firewall\_ports) | Allowed firewall ports. Postgresql used 5432. | `list(number)` | <pre>[<br>  5432<br>]</pre> | no |
| <a name="input_database_instance_tier"></a> [database\_instance\_tier](#input\_database\_instance\_tier) | This specifies the kind of machine-type that we will be running it from. | `string` | `"db-g1-small"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | This is the name of the database. | `string` | n/a | yes |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | This is the database type that we are running the cloud sql instance. | `string` | `"POSTGRES_14"` | no |
| <a name="input_google_compute_global_address_name"></a> [google\_compute\_global\_address\_name](#input\_google\_compute\_global\_address\_name) | Global address for VPC name | `string` | `"postgres"` | no |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | Keyring attributes. | <pre>object({<br>    location = string<br>    name     = string<br>  })</pre> | n/a | yes |
| <a name="input_keys"></a> [keys](#input\_keys) | Key names and base attributes. Set attributes to null if not needed. | <pre>map(object({<br>    destroy_scheduled_duration    = optional(string)<br>    rotation_period               = optional(string)<br>    labels                        = optional(map(string))<br>    purpose                       = optional(string, "ENCRYPT_DECRYPT")<br>    skip_initial_version_creation = optional(bool, false)<br>    version_template = optional(object({<br>      algorithm        = string<br>      protection_level = optional(string, "HSM")<br>    }))<br><br>    iam = optional(map(list(string)), {})<br>    iam_bindings = optional(map(object({<br>      members = list(string)<br>      role    = string<br>      condition = optional(object({<br>        expression  = string<br>        title       = string<br>        description = optional(string)<br>      }))<br>    })), {})<br>    iam_bindings_additive = optional(map(object({<br>      member = string<br>      role   = string<br>      condition = optional(object({<br>        expression  = string<br>        title       = string<br>        description = optional(string)<br>      }))<br>    })), {})<br>  }))</pre> | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | This is the name of the network. | `string` | n/a | yes |
| <a name="input_private_service_connect_ip"></a> [private\_service\_connect\_ip](#input\_private\_service\_connect\_ip) | IP Address for Service connect. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | This is the project ID. Please set using a terraform.tfvars file. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | This is the region that we are going to be running the cloud sql instance from. | `string` | `"us-east4"` | no |

## Outputs

No outputs.
