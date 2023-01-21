# This file defines the terraform block, which Terraform uses to configures itself. This block specifies this Terraform configuration must use the aws provider that is within the v4.49.0 minor release. It also requires that you use a Terraform version greater than [v1.1.0.]

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.3.0"
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
  subnet_id = module.vpc.mini_vpc_subnet_id[0]
  vpc_security_group_ids = [module.security.webserver_security_group_id]
}

# import the alb module
module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.mini_vpc_id
  subnets = module.vpc.mini_vpc_subnet_id[*]
  security_groups = [module.security.alb_security_group_id]
  target_01 = module.ec2.webserver_id[0]
  target_02 = module.ec2.webserver_id[1]
  target_03 = module.ec2.webserver_id[2]
}

# import the route53 module
module "route53" {
  source = "./modules/route53"
}

# create inventory file for use by ansible
resource "local_file" "host_inventory" {
  content = " ${module.ec2.webserver_public_ip[0]}\n ${module.ec2.webserver_public_ip[1]}\n ${module.ec2.webserver_public_ip[2]} "
  filename = "../ansible/host-inventory"
}

# provisioner "local-exec" {
#   command = "echo ${self.public_ip} >> host-inventory.txt"
# }