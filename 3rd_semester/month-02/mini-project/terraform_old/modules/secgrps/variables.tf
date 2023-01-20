variable "security_group_name" {
  description = "default name of security group"
  type        = string
  default     = "webserver-security-group"
}

variable "security_group_ingress_cidr" {
  description = "inbound CIDR block for security"
  type        = string
  default     = "0.0.0.0/0"
}

variable "security_group_ingress_rules" {
  description = "security group inbound rules"
  type        = list(string)
  default     = ["ssh-22-tcp","http-80-tcp","https-443-tcp"]
}

