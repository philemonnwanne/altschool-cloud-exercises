## Exercise-03 Solution

> TASK 1: Create 3 groups - admin, support and engineering and add the admin group to sudoers.

To carry out this task I took the following steps;

- Logged into my ubuntu virtual machine
- Gained root user privilage by running the command `sudo su` which grants me administrative rights
- To create the groups I ran the following commands:

> `groupadd admin` -- Creates the `admin` group 
>
> `groupadd support` -- Creates the `support` group 
> 
> `groupadd engineering` -- Creates the  `engineering` group 

To confirm that the groups were created successfully, I ran the following command:
> `tail /etc/group | grep staff`  --- See command output below

what this command does is to display the end of a file. By default, this command selects the last 10 lines of the file and displays them, in this case the `etc/group file`. And the grep command searches the file for the argument passed after it and fetches every occurence of that argument in this case `staff`


![etc/group-cmdOutput](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-01%20Week-04/Exercise-03/images/etc:group.png)

<br>

> TASK 2: Create a user in each of the groups

To carry out this task I took the following steps;

  While still logged in as the root user
- To create the groups I ran the following commands:
> `groupadd admin` -- Creates the group admin
>
> `groupadd support` -- Creates the group support
> 
> `groupadd engineering` -- Creates the group engineering

To confirm that the users were created successfully, I ran the following command:
> `tail /etc/passwd | grep staff`  --- See command output below

what this command does is to display the end of a file. By default, this command selects the last 10 lines of the file and displays them, in this case the `etc/passwd file`. And the grep command searches the file for the argument passed after it and fetches every occurence of that argument in this case `staff`

![etc/passwd-cmdOutput](https://github.com/philemonnwanne/altschool-cloud-exercises/blob/main/Month-01%20Week-04/Exercise-03/images/etc:passwd.png)


> TASK 3: Generate SSH keys for the user in the admin group

To carry out this task I took the following steps;
### I did the following
- Switched from `root` to the admin-user `(admin-staff)` using the command `sudo su`
- I try to confirm if I am the curren tuser by running the commands
- 
- `whoami` -- To confirm the current logged in user (the user in the admin group.)

  ![whoami](whoami)

- Then I run `pwd` -- To confirm my present working directory

[pwd](pwd)

- `ssh-keygen` -- To generate SSH keys for the user in the admin group

> Note: This gives an error message whichh was as a result of the user being created via the `ssh-keygen` command, as thi creates just a user without a home profile. Another alternativer was to create the user with the `adduser` command.

[ssh-keygen-error](ssh-keygen-error)

> To fix the error, I run the follwoing commands

> `mkdir /home/admin-staff` -- #to create the directory /home/admin-staff
>
> `ls /home` -- To confirm that the diractory was created
> 
> `cp -rT /etc/skel /home/admin-staff` -- #to populate /home/admin-staff with default files and folders

> `ls -al /home/admin-staff` -- To confirm presence of the default files and folders

> `chown -R admin-staff:admin-staff /home/admin-staff` -- #to change the owner of /home/admin-staff to user admin-staff

> `su admin-staff` -- To switch user back to admin-staff

> `cd home/admin-staff` -- To navigate to the home directory of `admin-staff`

> `whoami` -- To confirm the current logged in user

> `pwd` -- To confirm my present working directory

> `ssh-keygen` -- To generate SSH keys for the logged in user

