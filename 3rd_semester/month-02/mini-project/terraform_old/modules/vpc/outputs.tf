output "vpc-id" {
    description = "id of project VPC"
    value = module.vpc.vpc_id
}

output "vpc-subnet-id" {
    description = "subnet id of project VPC"
    value = module.vpc.public_subnets
}
