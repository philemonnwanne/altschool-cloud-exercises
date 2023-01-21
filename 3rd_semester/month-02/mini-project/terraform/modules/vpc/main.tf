/* 
this block configures a (VPC) module, which provisions networking resources such as a VPC, subnets, internet and NAT gateways
*/

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${var.vpc_name}"
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  private_subnet_names = var.vpc_private_subnets_names
  public_subnets  = var.vpc_public_subnets
  public_subnet_names = var.vpc_public_subnets_names
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}