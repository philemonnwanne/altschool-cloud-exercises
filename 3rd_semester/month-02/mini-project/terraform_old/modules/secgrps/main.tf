/* 
this block creates security groups for use with the webserver instances
*/

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.17.1"

  name        = var.security_group_name
  description = "security group for webservers with custom ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = var.security_group_ingress_cidr
  ingress_rules            = var.security_group_ingress_rules
  
}
