# Exercise 6

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


## 1. INITIAL SETUP
### 1.1 Filesystem Configuration
For the purpose of this benchmark, the requirement is to ensure that directories used for system-wide functions can be further protected by placing them on separate partitions. This provides protection for resource exhaustion and enables the use of mounting options that are applicable to the directory's intended use. 

### 1.1.23 Disable Automounting (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 2 - Workstation

### Description:
autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives.

### Rationale:
With automounting enabled anyone with physical access could attach a USB drive or disc and have its contents available in system even if they lacked permissions to mount it themselves.

### Impact:
The use of portable hard drives is very common for workstation users. If your organization allows the use of portable storage or media on workstations and physical access controls to workstations is considered adequate there is little value add in turning off automounting.

### Audit:
autofs should be removed or disabled.
Run the following command to verify that autofs is not installed or is disabled

`dpkg -s autofs`

###### Output should include:

```python
package `autofs` is not installed
```
###### My Output:

```ruby
root@ubuntu:~# dpkg -s autofs
dpkg-query: package 'autofs' is not installed and no information is available
Use dpkg --info (= dpkg-deb --info) to examine archive files.
root@ubuntu:~# 
```
This confirms that `autofs` is not installed on my system and is in compliance with the above recommendation.


## 1.4 Secure Boot Settings
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

###### My Output:
```ruby
root@ubuntu:/# grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked"
root is locked
root@ubuntu:/# 
```
This confirms that a password is set for the root user and is in compliance with the above recommendation.



## 2. SERVICES
### 2.1 Special Purpose Services
This section describes services that are installed on systems that specifically need to run these services. If any of these services are not required, it is recommended that they be deleted from the system to reduce the potential attack surface. If a package is required as a dependency, and the service is not required, the service should be stopped and masked.


### 2.1.1.1 Ensure time synchronization is in use (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 1 - Workstation

### Description:
System time should be synchronized between all systems in an environment. This is typically done by establishing an authoritative time server or set of servers and having all systems synchronize their clocks to them.

> Notes:
- If access to a physical host's clock is available and configured according to site policy, this section can be skipped
- Only one time synchronization method should be in use on the system
- If access to a physical host's clock is available and configured according to site policy,systemd-timesyncd should be stopped and masked

### Rationale:
Time synchronization is important to support time sensitive security mechanisms like Kerberos and also ensures log files have consistent time records across the enterprise, which aids in forensic investigations.

### Audit:
On physical systems or virtual systems where host based time synchronization is not available verify that *timesyncd*, chrony, or NTP is installed. Use one of the following commands to determine the needed information:

###### If systemd-timesyncd is used:
`systemctl is-enabled systemd-timesyncd`

###### If chrony is used:
`dpkg -s chrony`

###### If ntp is used:
`dpkg -s ntp`

###### My Output:
```ruby
root@ubuntu:/home/vagrant# systemctl is-enabled systemd-timesyncd
enabled
root@ubuntu:/home/vagrant# 
```
This confirms that `time synchronization` is in use on my system and complies with the above recommendation.

### 2.1.5 Ensure DHCP Server is not installed (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 1 - Workstation

### Description:
The Dynamic Host Configuration Protocol (DHCP) is a service that allows machines to be dynamically assigned IP addresses.

### Rationale:
Unless a system is specifically set up to act as a DHCP server, it is recommended that this package be removed to reduce the potential attack surface.

### Audit:
Run the following commands to verify isc-dhcp-server is not installed:
`dpkg -s isc-dhcp-server | grep -E '(Status:|not installed)'`

###### My Output:
```ruby
root@ubuntu:/home/vagrant# dpkg -s isc-dhcp-server | grep -E '(Status:|not installed)'
dpkg-query: package 'isc-dhcp-server' is not installed and no information is available
Use dpkg --info (= dpkg-deb --info) to examine archive files.
root@ubuntu:/home/vagrant# 
```
This confirms that `DHCP Server` is not installed on my system and complies with the above recommendation.


## 3. NETWORK CONFIGURATION
### 3.1 Disable unused network protocols and devices
For the purpose of this benchmark, the requirement is to ensure that unused network protocols and devices should be disabled inorder to reduce the attack surface of a system.

### 3.1.2 Ensure wireless interfaces are disabled (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 2 - Workstation

### Description:
Wireless networking is used when wired networks are unavailable. Debian contains a wireless tool kit to allow system administrators to configure and use wireless networks.

### Rationale:
If wireless is not to be used, wireless devices can be disabled to reduce the potential attack surface.

### Impact:
Many if not all laptop workstations and some desktop workstations will connect via wireless requiring these interfaces be enabled.

### Audit:
Run the following script to verify no wireless interfaces are active on the system:

```bash
#!/bin/bash
if command -v nmcli >/dev/null 2>&1 ; then
if nmcli radio all | grep -Eq '\s*\S+\s+disabled\s+\S+\s+disabled\b'; then
     echo "Wireless is not enabled"
  else
     nmcli radio all
  fi
elif [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then t=0
mname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless |
xargs -0 dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u)
for dm in $mname; do
if grep -Eq "^\s*install\s+$dm\s+/bin/(true|false)"
/etc/modprobe.d/*.conf; then
      /bin/true
    else
      echo "$dm is not disabled"
      t=1
fi done
  [ "$t" -eq 0 ] && echo "Wireless is not enabled"
else
  echo "Wireless is not enabled"
fi
```

###### Output should be:
Wireless is not enabled

###### My Output:
```ruby
root@ubuntu:/home/vagrant# nano bash.sh
root@ubuntu:/home/vagrant# ./bash.sh
bash: ./bash.sh: Permission denied
root@ubuntu:/home/vagrant# ls -l
total 4
-rw-r--r-- 1 root    root    717 Sep 16 09:28 bash.sh
root@ubuntu:/home/vagrant# chmod 744 bash.sh
root@ubuntu:/home/vagrant# ls -l
total 4
-rwxr--r-- 1 root    root    717 Sep 16 09:28 bash.sh
root@ubuntu:/home/vagrant# ./bash.sh
Wireless is not enabled
root@ubuntu:/home/vagrant# 
```
