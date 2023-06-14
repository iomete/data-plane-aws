

module "data-plane-aws" {
  source                    = "iomete/data-plane-aws/aws"
  version                   = "1.0.0"
  region                    = "us-east-1"  
  cluster_id                = "kgnwqy"  

  # the followings are your lakehouse bucket name and role name to access it
	lakehouse_role_name 		  = "iomete-lakehouse-role-kgnwqy"
	lakehouse_bucket_name     = "iomete-lakehouse-bucket-kgnwqy"
 
  #optional | additional_administrators = ["arn:aws:iam::1234567890:user/your_arn", "arn:aws:iam::1234567890:user/user2", "arn:aws:iam::1234567890:user/user3"] # list of IAM users or roles that can administer the KMS key and Kubernetes
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




