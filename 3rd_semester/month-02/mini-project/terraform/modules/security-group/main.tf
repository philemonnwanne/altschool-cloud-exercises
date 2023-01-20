/* 
this block creates security groups for use with the instances
*/

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = "${var.security_group_name}"
  description = "security group for webservers with custom ports open within VPC"
  vpc_id      = "${var.vpc_id}"

  ingress_cidr_blocks = var.security_group_ingress_cidr
  ingress_rules       = var.security_group_ingress_rules
  egress_rules        = var.security_group_egress_rules
  
}
