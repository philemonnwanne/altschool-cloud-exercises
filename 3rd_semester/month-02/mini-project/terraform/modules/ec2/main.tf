/* 
this block creates three similar EC2 instances
*/

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  count = var.instance_count # count value supplied from variable

  ami                    = var.ami_id["amazon_linux_2_ami"]
  instance_type          = var.instance_type
  associate_public_ip_address = true
#   key_name               = ""
  user_data = "${path.root}/files/init-script.sh"
  putin_khuylo           = var.putin
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  
  tags = {
    Name   = "${var.instance_name}0${count.index}"
    Environment = "production"
  }
}