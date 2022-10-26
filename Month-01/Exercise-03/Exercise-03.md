# Exercise-03

### Task:
- Create 3 groups – admin, support & engineering and add the admin group to sudoers.
- Create a user in each of the groups.
- Generate SSH keys for the user in the admin group.

### Instruction:
 - [ ] Submit the contents of /etc/passwd, /etc/group, /etc/sudoers

### Procedure
- Log into your ubuntu virtual machine
- Gain root user privilage by running the command `sudo su`
- To create the groups run the following commands:


### Create 3 groups

The `groupadd` command is used to create a group  in linux. So to create the three groups as instructed above, run the following commands.

```
groupadd admin

groupadd support

groupadd engineering
```

To confirm that the groups were created successfully run the next command
```
cat /etc/group | grep staff
```

> This command displays the contents of a file and the `grep` command searches the file for the argument passed after it and fetches every occurence of that argument in this case `staff`

```python
root@ubuntu:/home/vagrant/altschool# cat /etc/group | grep staff
staff:x:50:
admin:x:1001:admin-staff
support:x:1002:support-staff
engineering:x:1003:engineering-staff
admin-staff:x:1004:
support-staff:x:1005:
engineering-staff:x:1006:
```


### Create a user in each of the groups

To add a user to each group, run the `useradd` command

```
useradd -G admin admin-staff
```
<samp>creates  and adds the `admin-staff` user to the `admin` group</samp>

```
useradd -G support support-staff
```
<samp>creates  and adds the `support-staff` user to the `support` group</samp>

```
useradd -G engineering engineering-staff
```
<samp>creates  and adds the `engineering-staff` user to the `engineering` group</samp> 

> Notice that I added the `-G` option, and what this does is to add a secondary group to the user upon it's creation. Note the user will already have a default primary group which will reman unaffected.


To confirm that the users were created successfully run the next command

```
tail /etc/passwd | grep staff
```

> This command displays the end of a file, and by default it selects the last 10 lines of the file and displays them. And the grep command searches the file for the argument passed after it and fetches every occurence of that argument in this case `staff`

```python
root@ubuntu:/home/vagrant/altschool# tail /etc/passwd | grep staff
admin-staff:x:1001:1004::/home/admin-staff:/bin/sh
support-staff:x:1002:1005::/home/support-staff:/bin/sh
engineering-staff:x:1003:1006::/home/engineering-staff:/bin/sh
```


### Generate SSH keys for the user in the admin group

To generate ssh keys for the `admin-staff` user, we have to switch to that user
```
su admin-staff
```

Run the following command to confirm that you are the desired user
```
whoami
```

Your output should look similar to mine
```php
$ whoami
admin-staff
```

Now inorder to generate ssh keys for the current user run the following command

```
ssh-keygen
```

> Note: This gave me an error message which was as a result of the user being created via the `useradd` command, as this creates just a user without a home directory. Another alternativer was to create the user with the `adduser` or `user -m` command.
<br>

To fix the error, I ran the followoing commands

```
mkdir /home/admin-staff
``` 
- <samp>creates the directory `/home/admin-staff`</samp>
<br>

```
ls /home
```
- <samp>confirms that the directory was created</samp>
<br>

```
cp -rT /etc/skel /home/admin-staff
```
- <samp>populates /home/admin-staff with default files and folders</samp>
<br>

```
ls -al /home/admin-staff
```
- <samp>confirms presence of the default files and folders</samp>
<br>

```
chown -R admin-staff:admin-staff /home/admin-staff
``` 
- <samp>changes the owner of /home/admin-staff to user admin-staff</samp>
<br>

Now that the `admin-staff` user has a home directory we can proceed to generate ssh keys for them. So run the `ssh-keygen` command again.

```
ssh-keygen
```

Accept all prompts for you to have the default configuration. If the command was successful, you should a similar output to the one below.

```bash
vagrant@ubuntu:~$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/vagrant/.ssh/id_rsa
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:c9VEwnDWqPDb+V2cwWNcmTcnd7XDO93DPqMnztnXisk vagrant@ubuntu
The key's randomart image is:
+---[RSA 3072]----+
|          .o++o =|
|        .  oo+++B|
|         o .. +**|
|          o.  .*=|
|        S .o ..**|
|         o. o ..=|
|             . =o|
|           ..+=.*|
|            E=+o.|
+----[SHA256]-----+
```
