output "webserver_secgrp_id" {
    description = "security group controlling traffic access to the webserver instances"
    value = module.security_group.security_group_id
}