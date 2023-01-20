variable "aws_region" {
  description = "region to deploy all aws project resources"
  type        = string
  default     = "us-east-1"
}

variable "ssl_cert" {
  description = "the id of the instance to be deployed"
  type        = string
  default     = "arn:aws:acm:us-east-1:183066416469:certificate/ed9b93c3-253c-4f46-b2e2-370a7734fdb2"
}
