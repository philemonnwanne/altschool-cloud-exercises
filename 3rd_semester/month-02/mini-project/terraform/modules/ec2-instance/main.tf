/* 
this block creates three EC2 instances
*/

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  count = var.instance_count # count value supplied from variable

  name                   = "${var.instance_name}0${count.index}"
  ami                    = var.ami_id["amazon_linux_2_ami"]
  instance_type          = var.instance_type
  associate_public_ip_address = true
#   key_name               = ""
  putin_khuylo           = var.putin
  # vpc_security_group_ids = "${var.instance_secgrp_id}"
  # subnet_id = "${var.vpc_subnet_id}"

  vpc_security_group_ids = [module.security-group.webserver_secgrp_id]
  subnet_id = element(module.vpc.public_subnets, 0)


  tags = {
    Name   = "Server-0${count.index}"
    Environment = "prod"
  }
}