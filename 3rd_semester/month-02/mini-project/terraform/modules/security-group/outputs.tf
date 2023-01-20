output "webserver_secgrp_id" {
    description = "security groups controlling traffic access to the webserver instances"
    value = module.security-group.security_group_id
}