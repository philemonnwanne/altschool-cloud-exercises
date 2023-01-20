variable "security_group_name" {
  description = "default name of security group"
  type        = string
  default     = "webserver-security-group"
}

variable "vpc_id" {
  description = "default id of VPC"
  type        = string
}

variable "security_group_ingress_cidr" {
  description = "inbound CIDR block for security"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "security_group_ingress_rules" {
  description = "security group inbound rules"
  type        = list(string)
  default     = ["https-443-tcp"]
}

variable "security_group_egress_rules" {
  description = "security group outbound rules"
  type        = list(string)
  default     = ["all-all"]
}

