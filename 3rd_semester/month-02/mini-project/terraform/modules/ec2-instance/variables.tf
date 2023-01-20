variable "ami_id" {
  description = "the id of the machine image (AMI) to use for creating the server"
  type        = map
  default     = {
    "amazon_linux_2_ami" : "ami-0b5eea76982371e91",
    "ubuntu_ami" : "ami-0574da719dca65348"
  }
  validation {
    condition     = length(var.ami_id.ubuntu_ami) > 4 && substr(var.ami_id.ubuntu_ami, 0, 4) == "ami-" || length(var.ami_id.amazon_linux_2_ami) > 4 && substr(var.ami_id.amazon_linux_2_ami, 0, 4) == "ami-"
    error_message = "the image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "instance_count" {
  description = "create 3 similar EC2 instances"
  type        = number
  default     = 3
}

variable "instance_name" {
  description = "name prefix to assign to webserver instances"
  type        = string
  default     = "webserver-"
}

# variable "instance_secgrp_id" {
#   description = "security group to associate with the webserver instances"
#   # type        = list(string)
#   # default = [ "" ]
# }

# variable "vpc_subnet_id" {
#   description = "VPC subnet to launch instance"
#   # type        = string
#   # default = ""
# }

# variable "amazon_linux_2_ami" {
#   description = "the id of the machine image (AMI) to use for creating the server"
#   type        = string
#   default     = "ami-0b5eea76982371e91"
#   validation {
#     condition     = length(var.amazon_linux_2_ami) > 4 && substr(var.amazon_linux_2_ami, 0, 4) == "ami-"
#     error_message = "the image_id value must be a valid AMI id, starting with \"ami-\"."
#   }
# }

# variable "ubuntu_ami" {
#   description = "the id of the machine image (AMI) to use for creating the server"
#   type        = string
#   default     = "ami-0574da719dca65348"
#   validation {
#     condition     = length(var.ubuntu_ami) > 4 && substr(var.ubuntu_ami, 0, 4) == "ami-"
#     error_message = "the image_id value must be a valid AMI id, starting with \"ami-\"."
#   }
# }

variable "instance_type" {
  description = "the size of the instance to be deployed"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "the script to run on (first) instance boot"
  type        = string
  default     = "./files/init-script.sh"
}

variable "putin" {
  description = "putin_khuylo means {putin [is a] dickhead}. The phrase has become a protest song and is widely spread in Ukraine amongst supporters of Ukrainian sovereignty and territorial integrity, as well as those opposing Vladimir Putin in both Russia and Ukraine."
  type        = bool
  default     = "true"
}
