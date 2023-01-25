# This file defines the terraform block, which Terraform uses to configures itself. This block specifies this Terraform configuration must use the aws provider that is within the v4.49.0 minor release. It also requires that you use a Terraform version greater than [v1.1.0.]
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
  }
  required_version = ">= 1.1.0"
}

# this block configures the AWS provider
provider "aws" {
  region = local.region
}

# define common tags to be assigned to all VPC resources
locals {
  region = var.aws_region
  tags = {
    Owner = "Philemon Nwanne"
    Track = "Cloud/DevOps"
  }
}

# import the vpc module
module "vpc" {
  source = "./modules/vpc"
  vpc_name = "mini-vpc"
  tags = local.tags
}

# import the security module
module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.mini_vpc_id
}

# import the ec2 module
module "ec2" {
  source = "./modules/ec2"
  count = length(module.vpc.mini_vpc_subnet_id)
  subnet_id = element("${module.vpc.mini_vpc_subnet_id[*]}", count.index)
  availability_zone = element("${module.vpc.azs[*]}", count.index)
  vpc_security_group_ids = [module.security.webserver_security_group_id]

  tags = {
    Name   = "${var.instance_name}0${count.index + 1}"
    Environment = "production"
  }
}

# import the alb module
module "alb" {
  source = "./modules/alb"
  # count = 3
  vpc_id = module.vpc.mini_vpc_id
  subnets = module.vpc.mini_vpc_subnet_id[*]
  security_groups = [module.security.alb_security_group_id]
  target_01 = module.ec2.*.webserver_id[0]
  target_02 = module.ec2.*.webserver_id[1]
  target_03 = module.ec2.*.webserver_id[2]
}

# import the route53 module
module "route53" {
  source = "./modules/route53"
}

# create inventory file for use by ansible
resource "local_file" "host_inventory" {
  content = " '[webservers]'\n ${module.ec2.*.webserver_public_ip[0]}\n ${module.ec2.*.webserver_public_ip[1]}\n ${module.ec2.*.webserver_public_ip[2]} '[webservers:vars]' "
  filename = "../ansible/host-inventory"
}

# create inventory file for use by ansible
resource "local_file" "key_pair" {
  content = "${module.ec2.*.webserver-key[0]}"
  filename = "../ansible/webserver-key.pem"
  directory_permission = "0777"
  file_permission = "0400"
}

# provisioner "local-exec" {
#   command = "echo ${self.public_ip} >> host-inventory.txt"
# }