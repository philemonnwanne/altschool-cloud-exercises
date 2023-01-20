/* This file defines the terraform block, which Terraform uses to configures itself. This block specifies this Terraform configuration must use the aws provider that is within the v4.49.0 minor release. It also requires that you use a Terraform version greater than v1.1.0.
*/

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

/* this block configures the AWS provider */
provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_name = "mini-vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.mini_vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.vpc.mini_vpc_subnet_id
  vpc_security_group_ids = [module.security.webserver_secgrp_id]
}

module "alb" {
  source = "./modules/alb"
}

module "route53" {
  source = "./modules/route53"
}

resource "local_file" "host_inventory" {
  content = "module.ec2.webserver_public_ip"
  filename = "../hosts"
}

# provisioner "local-exec" {
#   command = "echo ${self.public_ip} >> host-inventory.txt"
# }