variable "aws_region" {
  description = "region to deploy all aws project resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_shared_credentials_files" {
  description = "path to the aws shared credentials file"
  default     = ["/home/vagrant/.aws/credentials"]
}

variable "aws_shared_config_files" {
  description = "path to the aws shared configuration file"
  default     = ["/home/vagrant/.aws/config"]
}

variable "ssl_cert" {
  description = "the id of the instance to be deployed"
  type        = string
  default     = "arn:aws:acm:us-east-1:183066416469:certificate/ed9b93c3-253c-4f46-b2e2-370a7734fdb2"
}

# variable "amazon_linux_2_ami" {
#   description = "the id of the machine image (AMI) to use for the server"
#   type        = string
#   default     = "ami-0b5eea76982371e91"
#   validation {
#     condition     = length(var.amazon_linux_2_ami) > 4 && substr(var.amazon_linux_2_ami, 0, 4) == "ami-"
#     error_message = "the image_id value must be a valid AMI id, starting with \"ami-\"."
#   }
# }