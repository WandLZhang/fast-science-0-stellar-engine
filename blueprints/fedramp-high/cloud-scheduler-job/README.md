# Cloud Scheduler
This blueprint schedules a cron job to publish a PubSub message or an HTTP request every X interval of time.

<!-- BEGIN TOC -->
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [description](variables.tf#L15) | Description of job. | <code>string</code> | ✓ |  |
| [main_project_id](variables.tf#L26) | Project id. | <code>string</code> | ✓ |  |
| [name](variables.tf#L55) | Name of the Cloud Scheduler job. | <code>string</code> | ✓ |  |
| [region](variables.tf#L66) | Location to deploy job. | <code>string</code> | ✓ |  |
| [schedule](variables.tf#L77) | Schedule to implement the job -- use cron-based syntax. | <code>string</code> | ✓ |  |
| [create_topic](variables.tf#L1) | Set the name of the topic to create a pubsub topic. | <code title="object&#40;&#123;&#10;  name &#61; string&#10;&#125;&#41;">object&#40;&#123;&#8230;&#125;&#41;</code> |  | <code>null</code> |
| [data](variables.tf#L9) | Uneoncoded data to be sent. | <code>string</code> |  | <code>null</code> |
| [kms_key_name](variables.tf#L20) | Full path to KMS key for pubsub. | <code>string</code> |  | <code>null</code> |
| [max_backoff_duration](variables.tf#L31) | Max backoff duration. | <code>string</code> |  | <code>null</code> |
| [max_doublings](variables.tf#L37) | Max doublings. | <code>number</code> |  | <code>null</code> |
| [max_retry_duration](variables.tf#L43) | Maximum retry duration. | <code>string</code> |  | <code>null</code> |
| [min_backoff_duration](variables.tf#L49) | Minimum backoff duration. | <code>string</code> |  | <code>null</code> |
| [new_topic_name](variables.tf#L60) | Name for new PubSub topic if creating one. | <code>string</code> |  | <code>null</code> |
| [retry_count](variables.tf#L71) | Number of retries. | <code>number</code> |  | <code>null</code> |
| [topic_id](variables.tf#L82) | PubSub topic ID. | <code>string</code> |  | <code>null</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [id](outputs.tf#L1) | Job ID. |  |
| [state](outputs.tf#L6) | Job state. |  |
<!-- END TFDOC -->
