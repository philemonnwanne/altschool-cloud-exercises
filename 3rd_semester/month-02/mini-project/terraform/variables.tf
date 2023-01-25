variable "aws_region" {
  description = "region to deploy all aws project resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "name prefix to assign to webserver instances"
  type        = string
  default     = "webserver-"
}