/* 
this block configures a (VPC) module, which provisions networking resources such as a VPC, subnets, internet and NAT gateways
*/

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = "${var.vpc_name}"
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

#   enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}