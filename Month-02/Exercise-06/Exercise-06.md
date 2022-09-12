## Exercise 6

### Task: 
Review the CIS benchmark for ubuntu and try to implement at least 10 of the recommendations that has been made within the benchmark.

### Focus Areas:
For hardening my linux system I decided to pick 12 recommendations cutting across the areas listed below

1. Initial Setup
2. Services
3. Network Configuration
4. Logging and Auditing
5. Access, Authentication and Authorization
6. System Maintenance

#### Note: 
> Due to the broad assumption of the guidance that operations are being performed as the root user, 
as well in order not to produce unexpected results or failure to make the the intended changes. 
I ensured that I was logged in as the root user while performing all operations.



## 1.1 Filesystem Configuration
For the purpose of this benchmark, the requirement is to ensure that directories used for system-wide functions can be further protected by placing them on separate partitions.

### 1.1.23 Disable Automounting (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 2 - Workstation

### Description:
autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives._

### Rationale:
With automounting enabled anyone with physical access could attach a USB drive or disc and have its contents available in system even if they lacked permissions to mount it themselves.

### Impact:
The use of portable hard drives is very common for workstation users. If your organization allows the use of portable storage or media on workstations and physical access controls to workstations is considered adequate there is little value add in turning off automounting.

### Audit:
autofs should be removed or disabled.
Run the following command to verify that autofs is not installed or is disabled

`# dpkg -s autofs`

Output should include:

```
package `autofs` is not installed
```
My Output:

```
root@ubuntu:~# dpkg -s autofs
dpkg-query: package 'autofs' is not installed and no information is available
Use dpkg --info (= dpkg-deb --info) to examine archive files.
root@ubuntu:~# 
```
This confirms that autofs is not installed on my system and compliance with the above recommendation.


## 1 - 1.4 Secure Boot Settings
The recommendations in this section focus on securing the bootloader and settings involved in the boot process directly.

### 1.4.4 Ensure authentication required for single user mode (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 1 - Workstation

### Description:
Single user mode is used for recovery when the system detects an issue during boot or by manual selection from the bootloader.

### Rationale:
Requiring authentication in single user mode prevents an unauthorized user from rebooting the system into single user to gain root privileges without credentials.

### Audit:
Perform the following to determine if a password is set for the root user:

`grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked"`

No results should be returned.

My Output:
```
root@ubuntu:/# grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked"
root is locked
root@ubuntu:/# 
```
This confirms that a password is set for the root user and compliance with the above recommendation.
