output "webserver_private_ip" {
    description = "private IP addresses of EC2 webserver instances"
    value = module.ec2-instance[*].private_ip
}

output "webserver_public_ip" {
    description = "public IP addresses of EC2 webserver instances"
    value = module.ec2-instance[*].public_ip
}

output "webserver_count" {
    description = "number of EC2 instances created"
    value = length(module.ec2-instance[*].id)
}