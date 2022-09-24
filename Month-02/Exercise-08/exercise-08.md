




#### Procedure
I enstalled ansible on the controlling machine or node
I created an inventory by adding my managed node to my `hosts` file.
I verified my inventory by running the command: `ansible all --list-hosts`
Output below:
```ruby
vagrant@apple:/etc/ansible$ ansible all --list-hosts
  hosts (1):
    172.19.0.2
```
Set up SSH connections so Ansible controller can connect to my managed nodes.
Tested the SSH connections with the command: `ssh vagrant@172.19.0.2` which returened a success (pong)
I also Ping the managed nodes with:
`ansible all -m ping`
Out put below:
```bash
vagrant@apple:/etc/ansible$ ansible all -m ping
172.19.0.2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

##### Inventory
Created a new inventory file named inventory.yaml in my home directory
Add my server to the inventory file by specifying the IP address 
Inventory file:
[]()

Verify your inventory. If you created your inventory in a directory other than your home directory, specify the full path with the -i option.

`ansible-inventory -i inventory.yaml --list`
Output. Below:
```ruby
vagrant@apple:/etc/ansible$ ansible-inventory inventory.yaml --list
{
    "_meta": {
        "hostvars": {}
    },
    "all": {
        "children": [
            "faangservers",
            "ungrouped"
        ]
    },
    "faangservers": {
        "hosts": [
            "172.19.0.2"
        ]
    }
}
```

Ping the managed nodes in my inventory. In this example, the group name is virtualmachines which you can specify with the ansible command instead of all.

ansible virtualmachines -m ping -i inventory.yaml
Output Below:
```ruby
vagrant@apple:~$ ansible servers -m ping -i inventory.yaml
amazon-server | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

Then I perfomed a dry run the issuing the command `ansible-playbook playbook.yaml --check`

> Note:  when you are creating or editing a playbook or role and you want to know what it will do. In check mode, Ansible runs without making any changes on remote systems. Modules that support check mode report the changes they would have made. Modules that do not support check mode report nothing and do nothing.

Output Here;

```python

```

#### UFW was disabled

###### Here's a the intial output of the timezonectl command on my server before modification by the ansible controller:
```bash
vagrant@google:~$ cat /etc/timezone
America/Aruba
```

