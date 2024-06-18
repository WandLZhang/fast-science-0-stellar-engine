
## Introduction Bastion Pattern (Bastion Pattern Project)
Bastions simplify secuirty administration. The internal network can be configured to block all the internet-bound traffic. It only allows SSH communications with the bastion host. The bastion pattern grants authorized users access access to a priate network from an external network such as internet. By following these steps, you will securely access multiple web services via the bastion host using port forwarding. This README section explains how to set up port forwarding for multiple ports and access the corresponding web services.
1. The IAM Permissions and Roles ```roles/cloudkms.cryptoKeyEncrypterDecrypter``` is assigned
Obtains access credentials for your user account via a web-based authorization flow. When this command completes successfully, it sets the active account in the current configuration to the account specified.

## Pre-requisite for Bastion Pattern Project (Bastion Pattern Project)
1. Have access to the GCP Project ID
2. You will need an existing [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) with [billing enabled](https://cloud.google.com/billing/docs/how-to/modify-project) and a user with the “Project owner” [IAM](https://cloud.google.com/iam) role on that project.
3. __Note__: to grant a user a role, take a look at the [Granting and Revoking Access](https://cloud.google.com/iam/docs/granting-changing-revoking-access#grant-single-role) documentation.

## How can you connect to the Bastion? 
To access the web portal through the bastion host, follow these steps:

1. **Set the Active Project** :
   ```bash
gcloud config set project set project <your-project-id>```

This command will configure the gcloud CLI to utilize the specified project for every subsequent command. Thus, you should replace your project ID of your project with the ID of your Google Cloud Platform project. 

2. **SSH into the Bastion Host via Port Forwarding**:
Use the following command to create an SSH tunnel through the bastion host and set up port forwarding for multiple ports:
gcloud compute ssh <your-bastion-host-name> --zone <your-zone> --tunnel-through-iap --project <your-project-id> -- \
-L 8443:<ip-of-bastion>:<remote-port1> \
-L 8444:<ip-of-bastion>:<remote-port2>\
-L 8445:<ip-of-bastion>::<remote-port3>```

For example, if you need to forward local ports 8443, 8444, and 8445 to remote ports 443, 8443, and 8444 on <ip-of-bastion>, respectively, you would use:
gcloud compute ssh management-bastion --zone us-east4-a --tunnel-through-iap --project example-prod-iac-core-0 -- \
-L 8443:192.168.1.10:443 \
-L 8444:192.168.1.10:8443 \
-L 8445:192.168.1.10:8444

In this example:
	•	-L 8443:192.168.1.10:443: Forwards local port 8443 to port 443 on the remote server.
	•	-L 8444:192.168.1.10:8443: Forwards local port 8444 to port 8443 on the remote server.
	•	-L 8445:192.168.1.10:8444: Forwards local port 8445 to port 8444 on the remote server.

3. **Access the Web Portals**:
Once the SSH tunnel is established, you can access the web services by navigating to these websites in your web browser:
	•	https://localhost:8443 for the service on remote port 443.
	•	https://localhost:8444 for the service on remote port 8443.
	•	https://localhost:8445 for the service on remote port 8444.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | Project ID GCP | `string` | n/a | yes |
| location |Location of project | `string` | n/a | yes |
| allowed_source_ranges |Allowed source ranges| `string` | n/a | yes |
| my_vpc |vpc name of project | `string` | n/a | yes |
| image|Image of the bastion vm | `string` | n/a | yes |
| zone |zone of the bastion instance | `string` | n/a | yes |
| my_subnet |Name of subnet | `string` | n/a | yes |
| instance_type |Type of instance | `string` | n/a | yes |
| ip_cidr_range |This is the ip cidr range | `string` | n/a | yes |
| disk_name|Name of disk| `string` | n/a | yes |
| instance_name |Name of instance| `string` | n/a | yes |
| kms_key_self_link |Self-link of kms key| `string` | n/a | yes |
| compute_service_account_id |id of Compute Service account| `string` | n/a | yes | 
| email | Email of user | `string` | n/a | yes |
| keyring | KMS keyring to use for encryption. Use terraform import 'module.kms.google_kms_key_ring.default[0]' projects/\<your-project\>/locations/\<your location\>/keyRings/\<your-keyring\> if you want to use an existing keyring| `string` | n/a | yes |
| keys | Key to use for encryption - defaults to the name "bastion". Use terraform import 'module.kms.google_kms_crypto_key.default["bastion"]' projects/\<your-project\>/locations/\<your-location\>/keyRings/\<your-keyring\>/cryptoKeys/bastion if you want to use an existing key | `list(string)` | `[]` | yes |
| iam | Identity and Access Management. |`list(string)` |  `[]` | yes |
| iam bindings| associates IAM policies with members | `list(string)`|  `[]` | yes |
| default|contains the duration, roation, protection, algorithm of the keys  | `list(string)` | `[]` | yes |

## How to deploy the Terraform Code. The Deployment Steps
You should see this README and some terraform files.
1. Update the Variables in the variables.tf and also the properties within the keys variables. For reference update the following variables and associated properties
2. There is a sample ```terraform.tfvars.sample``` available as well.
3. Although each use case is somehow built around the previous one they are self-contained so you can deploy any of them at your will. The usual terraform commands will do the work:

```bash
terraform init
terraform plan
terraform apply
```

It will take a few minutes. When complete, you should see an output stating the command completed successfully, a list of the created resources.

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

internal_ip = "10.0.0.2"
kms_key_self_link = "projects/my-repository/locations/us-east4/keyRings/my-keyring/cryptoKeys/default"
vpc_network = "https://www.googleapis.com/compute/v1/projects/my-repository-dev/global/networks/prod-mgmt-0"