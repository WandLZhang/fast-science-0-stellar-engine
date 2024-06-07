# Google Pub/Sub Project
This blueprint contains all the necessary Terraform modules to build and deploy a Pub/Sub. This is an asynchronous and scalable messaging service that decouples services producing messages from services processing those messages.

## Introduction
Pub/Sub allows services to communicate asynchronously, and it is used for streamlining analytics and data integration pipelines. The purpose of pub-sub is to load as well as transfer data. Pub-Sub permits latencies on the order of 100 milliseconds. Moreover, it enables the creation of systems of event producers and consumers, referred to as publishers and subscribers. The way that this works is that publishers communicate with subscribers asynchronously by broadcasting events instead of the synchronous remote procedure calls (RPCs). Then, publishers send events to the Pub/Sub service, without regard to how or when these events are to be processed. Afterwards, Pub/Sub delivers events to all the services that react to them. 

## Pre-requisite
1. The Principal (user or group) must have Cloud KMS Admin permission at the GCP Level.
2. Have access to the GCP Project ID
3.  You will need an existing [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) with [billing enabled](https://cloud.google.com/billing/docs/how-to/modify-project) and a user with the “Project owner” [IAM](https://cloud.google.com/iam) role on that project. __Note__: to grant a user a role, take a look at the [Granting and Revoking Access](https://cloud.google.com/iam/docs/granting-changing-revoking-access#grant-single-role) documentation.

# Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | Project ID GCP | `string` | n/a | yes |
| email | Email of the user| `string` | n/a | yes |
| location | Location of the project | `string` | n/a | yes |
| pubsub_subscription_name | Name of subscription| `string` | n/a | yes |
| pubsub_topic| Name of topic| `string` | n/a | yes |
| publisher_name| Name of publisher| `string` | n/a | yes |
| subscriber_name| Name of subscriber| `string` | n/a | yes |
| publisher_account_id| Name of publisher account id| `string` | n/a | yes |
| subscriber_account_id| Name of subscriber account id| `string` | n/a | yes |
| subscriber_account_id| Name of subscriber account id| `string` | n/a | yes |
| keyring | Keyring name | `string` | n/a | yes |
| keys | Key names. | `list(string)` | `[]` | yes |
| iam | Identity and Access Management. |`list(string)` |  `[]` | yes |
| iam bindings| associates IAM policies with members | `list(string)`|  `[]` | yes |
| default|contains the duration, roation, protection, algorithm of the keys  | `list(string)` | `[]` | yes |

## How to deploy the Terraform Code. The Deployment Steps
You should see this README and some terraform files.
1. Update the Variables in the variables.tf 
2. There is a sample ```terraform.tfvars.sample``` available as well.
3. Although each use case is somehow built around the previous one they are self-contained so you can deploy any of them at your will. The usual terraform commands will do the work:

```bash
terraform init
terraform plan
terraform apply
```

It will take a few minutes. When complete, you should see an output stating the command completed successfully, a list of the created resources.

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

Outputs:

publisher_service_account_email = "publisher@dev-repo.iam.gserviceaccount.com"
subscriber_service_account_email = "subscriber@dev-repo.iam.gserviceaccount.com"

