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
  vpc_security_group_ids = ["module.security-group.security_group_id"]
  subnet_id              = module.vpc.public_subnets

  tags = {
    Name   = "Server-0${count.index}"
    Environment = "prod"
  }
}