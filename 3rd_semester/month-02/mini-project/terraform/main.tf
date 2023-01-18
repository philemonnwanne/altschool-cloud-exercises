/* This file defines the terraform block, which Terraform uses to configures itself. This block specifies this Terraform configuration must use the aws provider that is within the v4.49.0 minor release. It also requires that you use a Terraform version greater than v1.1.0.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
  }
  required_version = ">= 1.1.0"
}

/* this block configures the AWS provider */
provider "aws" {
  region = var.aws_region
  shared_config_files      = var.aws_shared_config_files
  shared_credentials_files = var.aws_shared_credentials_files
}



module "vpc" {
  source = "./modules/vpc"
  vpc_name = "miniproject-vpc"
}

# module "ec2" {
#   source = "./modules/ec2"
#   ami_id = var.ami_id[0]
# }

module "ec2" {
  source = "./modules/ec2"
  amazon_linux_2_ami = var.amazon_linux_2_ami
}

module "alb" {
  source = "./modules/alb"
}

module "route53" {
  source = "./modules/route53"


}