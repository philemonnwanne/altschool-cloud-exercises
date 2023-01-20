output "instance_private_ip" {
    description = "private IP addresses of EC2 webserver instances"
    value = module.ec2-instance[*].private_ip
}

output "instance_public_ip" {
    description = "public IP addresses of EC2 webserver instances"
    value = module.ec2-instance[*].public_ip
}

output "instance_count" {
    value = length(module.ec2-instance[*].id)
}