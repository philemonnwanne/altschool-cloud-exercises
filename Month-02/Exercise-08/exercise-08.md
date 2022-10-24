
# Exercise 8

### Task:

- Create an Ansible Playbook to setup a server with Apache
- The server should be set to the Africa/Lagos Timezone
- Host an index.php file with the following content, as the main file on the server:
```php
<?php
date("F d, Y h:i:s A e", time());
?>
```
### Instruction:

 * [ ] Submit the Ansible playbook, the output of systemctl status apache2 after deploying the playbook and a screenshot of the rendered page



## Procedure
- Install ansible on the controlling machine or node

### Create and Verify Ansible Inventory File
- Create a new inventory file named inventory.yaml in my home directory
- Add your server to the inventory file by adding it's IP address to the file

**Inventory file:**
See my inventory file here [inventory](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-02/Exercise-08/inventory.yaml)

Verify your inventory. If you created your inventory in a directory other than your home directory, specify the full path with the -i option.

- **I verify my inventory by running the command:** `ansible-inventory -i inventory.yaml --list`

Output Below:
```ruby
vagrant@local:/etc/ansible$ ansible-inventory inventory.yaml --list
{
    "_meta": {
        "hostvars": {}
    },
    "all": {
        "children": [
            "ungrouped"
        ]
    },
        "hosts": [
            "172.19.0.2"
        ]
}
```

- **Pinged the managed node in my inventory using:** `ansible virtualmachines -m ping -i inventory.yaml`

**Output Below:**
```ruby
vagrant@local:~$ ansible servers -m ping -i inventory.yaml
amazon-server | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

Perfom a dry run by issuing the command: `ansible-playbook playbook.yaml --check`

> Note:  This is used when creating or editing a playbook or role to know what it will do. In check mode, Ansible runs without making any changes on remote systems. Modules that support check mode report the changes they would have made and modules that do not support check mode report nothing and do nothing.

**Output Here:**
```ruby
vagrant@local:~$ ansible-playbook -i inventory.yaml playbook.yaml --check

PLAY [deploy apache2 on host server[remote]] *************************************************

TASK [Gathering Facts] ***********************************************************************
ok: [172.19.0.2]

TASK [Update all packages to their latest version] *******************************************
ok: [172.19.0.2]

TASK [Install Apache server/PHP/Apache-PHP-module] *******************************************
ok: [172.19.0.2]

TASK [Remove useless packages from the cache & dependencies that are no longer required] *****
ok: [172.19.0.2]

TASK [Start/restart service apache2, if not started] *****************************************
changed: [172.19.0.2]

TASK [set timezone to Africa/Lagos] **********************************************************
ok: [172.19.0.2]

TASK [Copy my "index.php" file to the host server[remote]] ***********************************
ok: [172.19.0.2]

PLAY RECAP ***********************************************************************************
172.19.0.2                 : ok=7    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```


### Execute Playbook
Finally to get ansible to run plays in the playbook on the managed node use the command:
```ruby
vagrant@local:~$ ansible-playbook -i inventory.yaml playbook.yaml
```
**Output Here:**
```ruby
vagrant@local:~$ ansible-playbook -i inventory playbook.yml --check

PLAY [deploy apache2 on host server[remote]] *************************************************

TASK [Gathering Facts] ***********************************************************************
ok: [172.19.0.2]

TASK [Update all packages to their latest version] *******************************************
changed: [172.19.0.2]

TASK [Install Apache server/PHP/Apache-PHP-module] *******************************************
changed: [172.19.0.2]

TASK [Remove useless packages from the cache & dependencies that are no longer required] *****
changed: [172.19.0.2]

TASK [Start/restart service apache2, if not started] *****************************************
changed: [172.19.0.2]

TASK [set timezone to Africa/Lagos] **********************************************************
changed: [172.19.0.2

TASK [Copy my "index.php" file to the host server[remote]] ***********************************
changed: [172.19.0.2]

PLAY RECAP ***********************************************************************************
172.19.0.2                : ok=1    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

**In the above output you can see:**

- The names that you give the play and each task. You should always use descriptive names that make it easy to verify and troubleshoot playbooks.

- The Gather Facts task runs implicitly. By default Ansible gathers information about your inventory that it can use in the playbook.

- The status of each task. Each task has a status of ok which means it ran successfully.

- The play recap that summarizes results of all tasks in the playbook per host. In this example, there are three tasks so ok=3 indicates that each task ran successfully.

Congratulations! You have just created your first Ansible playbook.


### Intial output of the timezonectl before modification by the ansible controller:
```bash
vagrant@remote:~$ cat /etc/timezone
America/Aruba
```


### Final output of timezonectl:
```bash
vagrant@remote:~$ cat /etc/timezone
Africa/Lagos
```


![timezone-output](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-02/Exercise-08/images/etc-timezone.png)


