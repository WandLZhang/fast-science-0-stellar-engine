# Google Compute Engine VM with Security Onion 
Security Onion is a Linux distribution and open-source software suite designed for network security monitoring (NSM) and intrusion detection (IDS). It integrates various tools and platforms to provide a comprehensive solution for monitoring, alerting, and defending enterprise networks against cybersecurity threats.

 ## Pre-requisite
1. The Principal (user or group) must have Cloud KMS Admin, Able to Deploy a Google VPC, GKE Create, permission at the GCP Level.
2. Have access to the GCP Project ID
3.  You will need an existing [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) with [billing enabled](https://cloud.google.com/billing/docs/how-to/modify-project) and a user with the “Project owner” [IAM](https://cloud.google.com/iam) role on that project. __Note__: to grant a user a role, take a look at the [Granting and Revoking Access](https://cloud.google.com/iam/docs/granting-changing-revoking-access#grant-single-role) documentation.
4. __Important Note__: The project is scoped around the computer engine VM, and in order to deploy the code, there is a dependency on the Google VPC module (VPC and subnet), and the code uses the Google VPC module along with the Google KMS module. As per requirements, The CFF stages are supposed to set that up for new projects. 


## How to deploy the Terraform Code. The Deployment Steps
You should see this README and some terraform files.
1. Create an ```terraform.tfvars```. Copy the content from the  sample ```terraform.tfvars.sample```. Update the values in the ```terraform.tfvars```
2. Although each use case is somehow built around the previous one they are self-contained so you can deploy any of them at your will. The usual terraform commands will do the work:

```bash
terraform init
terraform plan
terraform apply
```


## Cleanup
Once the project is deployed, to ensure clean up, please apply following command.
```bash
terraform destory
```
