variable "security_group_name" {
  description = "security group default name"
  type        = string
  default     = "webserver-security-group"
}

variable "vpc_id" {
  description = "VPC default id"
  type        = string
}

variable "security_group_ingress_cidr" {
  description = "security group inbound CIDR block"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "security_group_ingress_rules" {
  description = "security group inbound rules"
  type        = list(string)
  default     = ["https-443-tcp"]
}

variable "security_group_egress_cidr" {
  description = "security group outbound CIDR block"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "security_group_egress_rules" {
  description = "security group outbound rules"
  type        = list(string)
  default     = ["all-all"]
}