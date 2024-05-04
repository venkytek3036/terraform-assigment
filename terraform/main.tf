##vpc-module##
module "vpc_apps" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name                        = "${local.prefix}-vpc-${local.env}"
  cidr                        = var.vpc_apps_cidr
  azs                         = var.aws_availability_zone_names
  private_subnets             = var.subnet_cidr.aws_managed_services_subnets.private
  public_subnets              = var.subnet_cidr.aws_managed_services_subnets.public
  enable_nat_gateway          = true
  single_nat_gateway          = var.multiple_nat_gateways ? false : true
  map_public_ip_on_launch     = false
  enable_dns_hostnames        = true
  tags = local.predefined-tags
}