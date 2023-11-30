data "aws_route_tables" "all" {
  vpc_id = module.vpc.vpc_id
}

resource "aws_vpc_endpoint" "this" {
  vpc_id            = module.vpc.vpc_id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.${var.region}.s3"
  route_table_ids   = data.aws_route_tables.all.ids

  tags = local.tags

  depends_on = [
    module.eks,
    module.vpc
  ]
}
