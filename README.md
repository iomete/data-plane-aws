# IOMETE Data-Plane module

## Terraform module which creates resources on AWS.


## References
- https://github.com/terraform-aws-modules/terraform-aws-eks

## Module Usage


## Terraform code

```hcl
module "data-plane-aws" {
  source                    = "iomete/data-plane-aws/aws"
  version                   = "2.1.0"
 
  region                    = "us-east-1"
  cluster_name              = "aws-test1"
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

## Terraform Deployment

```shell
terraform init
terraform plan
terraform apply
```