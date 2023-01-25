/* 
this block creates three similar EC2 instances with a keypair
*/

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  ami                    = var.ami_id["amazon_linux_2_ami"]
  instance_type          = var.instance_type
  associate_public_ip_address = true
  user_data = file("./files/init-script.tpl")
  vpc_security_group_ids = var.vpc_security_group_ids
  putin_khuylo           = var.putin
  key_name               = module.key_pair.key_pair_name
  subnet_id              = var.subnet_id
  availability_zone      = var.availability_zone
  
  tags = var.tags
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = "webserver-key"
  create_private_key = true
  create = false
}