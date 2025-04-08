# Cloud Run

This blueprint can deploy either a cloud run service or cloud run job on Google Cloud Platform (GCP) with Customer-Managed Encryption Keys (CMEK) using Cloud KMS. It provides a secure and flexible solution for running serverless applications.

## Introduction to Google Cloud Run
Google Cloud Platform's Cloud Run is a fully managed, serverless computing platform that enables developers to deploy and run containerized applications with ease. It abstracts away infrastructure management, automatically scaling applications up and down based on traffic, while only charging for the actual compute time used. Cloud Run supports stateless HTTP-based workloads, allowing applications to be deployed using any language or framework as long as they are packaged in a container. It offers both public and private access options, integrates with Google Cloud’s identity and access management (IAM) for secure access control, and can connect to various Google Cloud services, such as Cloud SQL, Pub/Sub, and Firestore. With built-in features for versioning, traffic splitting, and load balancing, Cloud Run is ideal for modern microservices architectures and applications that require scalability and low-latency response times.

## Disclaimer
- The present GCP Terraform Module in this project is set up and intended to be implemented in a FEDRAMP High environment using the Assured Workloads within the Google Cloud Platform (GCP) organization.

## Deployment Steps

You should see this README and some terraform files.
1. Update the Variables in the variables.tf and also the properties within the keys variables. For reference update the following variables and associated properties

- ```project_id```  with your GCP Project ID<br />
- ```region``` with the GCP region <br />
- ```name``` with the desired cloud run name <br />
- ```kms_key``` with the full path to the CMEK key that will be used for encryption <br />
- ```container_image``` with the container to be hosted on the cloud run service <br />


2. There is a sample ```terraform.tfvars.sample``` available as well.
3. Although each use case is somehow built around the previous one they are self-contained so you can deploy any of them at your will. The usual terraform commands will do the work. To provision this example, run the following from within this directory:

```terraform init ```<br />
```terraform plan``` to see the infrastructure plan<br />
```terraform apply``` to apply the infrastructure build<br />
```terraform destroy``` to destroy the built infrastructure<br />

<!-- BEGIN TOC -->
- [Introduction to Google Cloud Run](#introduction-to-google-cloud-run)
- [Disclaimer](#disclaimer)
- [Deployment Steps](#deployment-steps)
- [Variables](#variables)
- [Outputs](#outputs)
<!-- END TOC -->
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [container_image](variables.tf#L1) | Container image to be hosted on cloud run. | <code>string</code> | ✓ |  |
| [kms_key_name](variables.tf#L36) | Path to the kms key to use. | <code>string</code> | ✓ |  |
| [main_project_id](variables.tf#L41) | The Project ID. | <code>string</code> | ✓ |  |
| [name](variables.tf#L52) | Name of the cloud run instance to be created. | <code>string</code> | ✓ |  |
| [region](variables.tf#L63) | Region that Project is in. | <code>string</code> | ✓ |  |
| [cpu](variables.tf#L6) | Sets the CPU limit. 1000m = 1 vCPU. | <code>string</code> |  | <code>&#34;1000m&#34;</code> |
| [cpu_idle](variables.tf#L12) | Allows the container to scale to zero. | <code>bool</code> |  | <code>true</code> |
| [env_vars](variables.tf#L18) | Environment variables for the Cloud Run service or job. | <code>map&#40;string&#41;</code> |  | <code>&#123;&#125;</code> |
| [ingress](variables.tf#L24) | Ingress settings. | <code>string</code> |  | <code>&#34;INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER&#34;</code> |
| [is_job](variables.tf#L30) | Set to true to create a job instead of a service. | <code>bool</code> |  | <code>false</code> |
| [memory](variables.tf#L46) | Sets the memory limit. 512Mi = 512MiB. | <code>string</code> |  | <code>&#34;512Mi&#34;</code> |
| [port](variables.tf#L57) | Mapping of port number and port name to open. | <code>number</code> |  | <code>8080</code> |

## Outputs

| name | description | sensitive |
|---|---|:---:|
| [cloud_run](outputs.tf#L1) | Cloud Run Service that was created. |  |
| [service-account](outputs.tf#L6) | Service account that was created to run the Cloud Run Service. |  |
<!-- END TFDOC -->
