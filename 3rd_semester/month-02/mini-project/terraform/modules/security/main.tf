/* 
this block creates security groups for use with the instances
*/

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "${var.security_group_name}"
  description = "security group controlling traffic to webservers within the VPC"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks = var.security_group_ingress_cidr
  ingress_rules       = var.security_group_ingress_rules
  egress_cidr_blocks  = var.security_group_egress_cidr
  egress_rules        = var.security_group_egress_rules
}