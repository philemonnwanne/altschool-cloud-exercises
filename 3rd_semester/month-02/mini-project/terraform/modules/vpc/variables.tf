variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  description = "public subnets for VPC"
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "vpc_public_subnets_names" {
  description = "private subnet names for VPC"
  type        = list(string)
  default     = ["mini-subnet-public1-us-east-1a", "mini-subnet-public2-us-east-1b"]
}

variable "vpc_private_subnets" {
  description = "private subnets for VPC"
  type        = list(string)
  default     = ["10.0.128.0/20", "10.0.144.0/20"]
}

variable "vpc_private_subnets_names" {
  description = "private subnet names for VPC"
  type        = list(string)
  default     = ["mini-subnet-private1-us-east-1a", "mini-subnet-private2-us-east-1b"]
}

variable "tags" {
  description = "tags to apply to resources created by VPC module"
  type        = map(string)
  # default = {
  #   Identity = "knull"
  #   Environment = "production"
  #   Description = "this VPC was created to house my Altschool third semester mini-project"
  # }
}