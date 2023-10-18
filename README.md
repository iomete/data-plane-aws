# IOMETE Data-Plane module

## Terraform module which creates resources on AWS.


## References
- https://github.com/terraform-aws-modules/terraform-aws-eks

## Module Usage


## Data plane installation

Create a new folder and create a file (e.g. iomete-terraform.tf) with the following content:

```hcl
module "data-plane-aws" {
  source                    = "iomete/data-plane-aws/aws"
  version                   = "2.1.0"
 
  region                    = "us-east-1"
  cluster_name              = "lakehouse-dev"
}

################# 
# Outputs 
#################

output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.data-plane-aws.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.data-plane-aws.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate cluster with the IOMETE controlplane"
  value       = module.data-plane-aws.cluster_certificate_authority_data
}
```

## Run terraform

To run Terraform, execute the following commands in your terminal:

```shell
# Initialize Terraform
terraform init --upgrade

# Create a plan
terraform plan

# Apply the changes to your AWS account
terraform apply
```