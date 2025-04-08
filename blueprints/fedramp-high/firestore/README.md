# Firestore
This blueprint deploys a FedRAMP High compliant Firestore instance.

<!-- BEGIN TOC -->
- [Note](#note)
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->

## Note
CMEK is not supported out of the box - │ Error: Error creating Database: googleapi: Error 400: This project is not eligible to create CMEK databases. Please refer to https://cloud.google.com/firestore/docs/cmek to request access to this feature.

There is a bug where you must MANUALLY delete youre Firestore instance, even after running terraform destroy.
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [firestore_database_name](variables.tf#L11) | The name of the Firestore database instance. | <code>string</code> | ✓ |  |
| [main_project_id](variables.tf#L22) | The ID of the Google Cloud project. | <code>string</code> | ✓ |  |
| [region](variables.tf#L27) | The location ID where the Firestore database will be created. | <code>string</code> | ✓ |  |
| [backup_schedule](variables.tf#L1) | Backup schedule. | <code title="object&#40;&#123;&#10;  retention         &#61; string&#10;  daily_recurrence  &#61; optional&#40;bool, false&#41;&#10;  weekly_recurrence &#61; optional&#40;string&#41;&#10;&#125;&#41;">object&#40;&#123;&#8230;&#125;&#41;</code> |  | <code>null</code> |
| [kms_key_name](variables.tf#L16) | The KMS key name used to encrypt the Firestore database. | <code>string</code> |  | <code>null</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [firestore_earliest_version_time](outputs.tf#L1) | The earliest timestamp at which older versions of the data can be read from the database. |  |
| [firestore_etag](outputs.tf#L6) | This checksum is computed by the server based on the value of other fields. |  |
| [firestore_id](outputs.tf#L11) | The identifier for the Firestore resource. |  |
| [firestore_uid](outputs.tf#L16) | The system-generated UUID4 for this Database. |  |
| [firestore_version_retention_period](outputs.tf#L22) | The period during which past versions of data are retained in the database. |  |
<!-- END TFDOC -->
