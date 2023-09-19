provider "aws" {
  region = var.region
}
resource "random_id" "random" {
  byte_length = 3
}

locals {
  depends_on            = [resource.random_id.random]
  cluster_name          = "iomete-data-plane"
  module_version        = "1.1.0"
  lakehouse_role_name   = "iomete-lakehouse-role-${random_id.random.hex}"
  lakehouse_bucket_name = "iomete-lakehouse-bucket-${random_id.random.hex}"

  tags = {
    "iomete.com/cluster_name" : local.cluster_name
    "iomete.com/terraform" : true
    "iomete.com/managed" : true
  }
}

module "storage-configuration" {
  source                = "./modules/storage-configuration"
  aws_region            = var.region
  lakehouse_bucket_name = local.lakehouse_bucket_name
  lakehouse_role_name   = local.lakehouse_role_name
  cluster_role_arn      = aws_iam_role.cluster_lakehouse.arn
}


resource "null_resource" "save_outputs" {
  depends_on = [helm_release.fluxcd]
  triggers = {
    run_every_time = uuid()
  }
  provisioner "local-exec" {
    command = <<-EOT
    
    if [ ! -s "IOMETE_DATA" ]; then
    echo "EKS Name: $(terraform output cluster_name)" >> IOMETE_DATA &&
    echo "EKS Endpoint: $(terraform output cluster_endpoint)" >> IOMETE_DATA &&
    echo "Cluster CA Certificate: $(terraform output cluster_certificate_authority_data)" >> IOMETE_DATA
    fi


    EOT
  }
}
