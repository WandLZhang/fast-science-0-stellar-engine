# Google Compute Engine VM with Security Onion 
Security Onion is a  open-source software suite designed for network security monitoring (NSM) and intrusion detection (IDS). It is a solution for monitoring, alerting, and defending enterprise networks.

 ## Pre-requisite
1. The Principal (user or group) must have permission at GCP Level for deployment of Cloud KMS (Admin), Able to Deploy a Google VPC, Able to create GCP Compute Engine  VM.
2. Have access to the GCP Project ID
3.  You will need an existing [project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) with [billing enabled](https://cloud.google.com/billing/docs/how-to/modify-project) and a user with the “Project owner” [IAM](https://cloud.google.com/iam) role on that project. __Note__: To grant a user a role, take a look at the [Granting and Revoking Access](https://cloud.google.com/iam/docs/granting-changing-revoking-access#grant-single-role) documentation.
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


It will take a few minutes. When complete, you should see an output stating the command completed successfully, a list of the created resources.

The Output will look like following

## Verification of a successful Terraform/Infrastructure deployment?

- Go to the Google Compute Engine (GCE) in the GCP Console. Select the VM instance.

![Google Compute Engine](./images/gke1.png?raw=true "Google Compute Engine")
- Click on the Instance Name inside the Google Compute Engine Panel
 
 

## Configuration of the Security Onion 

## Cleanup
Once the project is deployed, to ensure clean up, please apply following command.
```bash
terraform destory
```
