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
This confirms that a password is set for the root user and is in compliance with the above recommendation.<br ><br >



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
This confirms that `DHCP Server` is not installed on my system and complies with the above recommendation.<br ><br >


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
This confirms that no wireless interfaces are active on my system, and complies with the above recommendation.


### 3.5 Firewall Configuration
A firewall is a set of rules. When a data packet moves into or out of a protected network space, its contents (in particular, information about its origin, target, and the protocol it plans to use) are tested against the firewall rules to see if it should be allowed through.

###### For the purpose of this benchmark note that:
- Only one method should be used to configure a firewall on the system. Use of more than one method could produce unexpected results.
- This section is intended only to ensure the resulting firewall rules are in place, not how they are configured.

### 3.5.1.1 Ensure ufw is installed (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 1 - Workstation

### Description:
The Uncomplicated Firewall (ufw) is a frontend for iptables and is particularly well-suited for host-based firewalls. ufw provides a framework for managing netfilter, as well as a command-line interface for manipulating the firewall

### Rationale:
A firewall utility is required to configure the Linux kernel's netfilter framework via the iptables or nftables back-end.
The Linux kernel's netfilter framework host-based firewall can protect against threats originating from within a corporate network to include malicious mobile code and poorly configured software on a host.

> Note: Only one firewall utility should be installed and configured. UFW is dependent on the iptables package

### Audit:
Run the following command to verify that Uncomplicated Firewall (UFW) is installed:
`dpkg -s ufw | grep 'Status: install'`

###### My Output:
```ruby
root@ubuntu:/home/vagrant# dpkg -s ufw | grep 'Status: install'
Status: install ok installed
root@ubuntu:/home/vagrant# 
```
This confirms that `ufw is installed` on my system and complies with the above recommendation.<br ><br >


## 4. LOGGING AND AUDITING
System auditing, through auditd, allows system administrators to monitor their systems such that they can detect unauthorized access or modification of data. By default, auditd will audit AppArmor AVC denials, system logins, account modifications, and authentication events. Events will be logged to `/var/log/audit/audit.log`. The recording of these events will use a modest amount of disk space on a system. If significantly more events are captured, additional on system or off system storage may need to be allocated.

> Notes:
- The recommendations in this section implement an audit policy that produces large quantities of logged data
- In some environments it can be challenging to store or process these logs and as such they are marked as Level 2 for both Servers and Workstations
- Audit rules that have `arch` as a rule parameter:
     - On 64 bit systems, you will need two rules, one for 64 bit and one for 32 bit
     - On 32 bit systems, only the 32 bit rule is needed

### 4.1.1.1 Ensure auditd is installed (Automated)

### Profile Applicability:
- Level 2 - Server
- Level 2 - Workstation

### Description:
auditd is the userspace component to the Linux Auditing System. It's responsible for writing audit records to the disk

### Rationale:
The capturing of system events provides system administrators with information to allow them to determine if unauthorized access to their system is occurring.

### Audit:
Run the following command and verify auditd is installed:
`dpkg -s auditd audispd-plugins`

###### My Initial Output:
```ruby
root@ubuntu:/home/vagrant# dpkg -s auditd audispd-plugins
dpkg-query: package 'auditd' is not installed and no information is available

dpkg-query: package 'audispd-plugins' is not installed and no information is available
Use dpkg --info (= dpkg-deb --info) to examine archive files.
root@ubuntu:/home/vagrant# 
```

This shows that `auditd` is not installed and doesn't comply with the above recommendation. To fix, I apply the below remediation:

### Remediation:
Run the following command to Install auditd:
`apt install auditd audispd-plugins`

###### My Command Output:
```ruby
root@ubuntu:/home/vagrant# dpkg -s auditd audispd-plugins
dpkg-query: package 'auditd' is not installed and no information is available

dpkg-query: package 'audispd-plugins' is not installed and no information is available
Use dpkg --info (= dpkg-deb --info) to examine archive files.
root@ubuntu:/home/vagrant# apt install auditd audispd-plugins
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  libauparse0 libltdl7 libprelude28 prelude-utils
The following NEW packages will be installed:
  audispd-plugins auditd libauparse0 libltdl7 libprelude28 prelude-utils
0 upgraded, 6 newly installed, 0 to remove and 4 not upgraded.
Need to get 570 kB of archives.
After this operation, 3485 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://ports.ubuntu.com/ubuntu-ports focal/main arm64 libauparse0 arm64 1:2.8.5-2ubuntu6 [46.5 kB]
Get:2 http://ports.ubuntu.com/ubuntu-ports focal/main arm64 libltdl7 arm64 2.4.6-14 [37.5 kB]
Get:3 http://ports.ubuntu.com/ubuntu-ports focal/universe arm64 libprelude28 arm64 5.1.1-5 [214 kB]
Get:4 http://ports.ubuntu.com/ubuntu-ports focal/universe arm64 prelude-utils arm64 5.1.1-5 [35.2 kB]
Get:5 http://ports.ubuntu.com/ubuntu-ports focal/main arm64 auditd arm64 1:2.8.5-2ubuntu6 [186 kB]
Get:6 http://ports.ubuntu.com/ubuntu-ports focal/universe arm64 audispd-plugins arm64 1:2.8.5-2ubuntu6 [51.5 kB]
Fetched 570 kB in 2s (319 kB/s)          
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libauparse0:arm64.
(Reading database ... 13053 files and directories currently installed.)
Preparing to unpack .../0-libauparse0_1%3a2.8.5-2ubuntu6_arm64.deb ...
Unpacking libauparse0:arm64 (1:2.8.5-2ubuntu6) ...
Selecting previously unselected package libltdl7:arm64.
Preparing to unpack .../1-libltdl7_2.4.6-14_arm64.deb ...
Unpacking libltdl7:arm64 (2.4.6-14) ...
Selecting previously unselected package libprelude28:arm64.
Preparing to unpack .../2-libprelude28_5.1.1-5_arm64.deb ...
Unpacking libprelude28:arm64 (5.1.1-5) ...
Selecting previously unselected package prelude-utils.
Preparing to unpack .../3-prelude-utils_5.1.1-5_arm64.deb ...
Unpacking prelude-utils (5.1.1-5) ...
Selecting previously unselected package auditd.
Preparing to unpack .../4-auditd_1%3a2.8.5-2ubuntu6_arm64.deb ...
Unpacking auditd (1:2.8.5-2ubuntu6) ...
Selecting previously unselected package audispd-plugins.
Preparing to unpack .../5-audispd-plugins_1%3a2.8.5-2ubuntu6_arm64.deb ...
Unpacking audispd-plugins (1:2.8.5-2ubuntu6) ...
Setting up libauparse0:arm64 (1:2.8.5-2ubuntu6) ...
Setting up libltdl7:arm64 (2.4.6-14) ...
Setting up auditd (1:2.8.5-2ubuntu6) ...
Created symlink /etc/systemd/system/multi-user.target.wants/auditd.service → /lib/systemd/system/auditd.service.
invoke-rc.d: policy-rc.d denied execution of start.
Setting up libprelude28:arm64 (5.1.1-5) ...
Setting up audispd-plugins (1:2.8.5-2ubuntu6) ...
Setting up prelude-utils (5.1.1-5) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.9) ...
Processing triggers for systemd (245.4-4ubuntu3.17) ...
```

###### My Final Output:
```ruby
root@ubuntu:/home/vagrant# dpkg -s auditd audispd-plugins
Package: auditd
Status: install ok installed
Priority: optional
Section: admin
Installed-Size: 644
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: arm64
Source: audit
Version: 1:2.8.5-2ubuntu6
Depends: lsb-base (>= 3.0-6), mawk | gawk, libaudit1 (>= 1:2.8), libauparse0 (>= 1:2.8), libc6 (>= 2.17)
Suggests: audispd-plugins
Conffiles:
 /etc/audisp/audispd.conf 4ca8c26bab8fa3119dc0e179970ec5eb
 /etc/audisp/plugins.d/af_unix.conf 199eaa1e43fa9139f0910bdb64fd219e
 /etc/audisp/plugins.d/syslog.conf 57421191efe78160bd7e085de99bf5cd
 /etc/audit/audit-stop.rules 45dc8b93a8b644d96197dc87b7b2b392
 /etc/audit/auditd.conf a6fb050cc84b0681a69f9093e3cd45f9
 /etc/audit/rules.d/audit.rules 9967a3542c449b61d688a4f4b465cdfa
 /etc/default/auditd bd36117b4a80ce610d7339ba117c4be8
 /etc/init.d/auditd 03975a59225fad7d7c28e133de85d249
Description: User space tools for security auditing
 The audit package contains the user space utilities for
 storing and searching the audit records generated by
 the audit subsystem in the Linux 2.6 kernel.
 .
 Also contains the audit dispatcher "audisp".
Homepage: https://people.redhat.com/sgrubb/audit/
Original-Maintainer: Laurent Bigonville <bigon@debian.org>

Package: audispd-plugins
Status: install ok installed
Priority: optional
Section: admin
Installed-Size: 174
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: arm64
Source: audit
Version: 1:2.8.5-2ubuntu6
Depends: auditd, libauparse0 (>= 1:2.5.1), libc6 (>= 2.17), libcap-ng0 (>= 0.7.9), libgssapi-krb5-2 (>= 1.17), libkrb5-3 (>= 1.6.dfsg.2), libldap-2.4-2 (>= 2.4.7), libprelude28
Conffiles:
 /etc/audisp/audisp-prelude.conf 50b64c6e11966ff70faec84c9f438d2b
 /etc/audisp/audisp-remote.conf 355d45d0595da0591c7c35af45b2c7f2
 /etc/audisp/plugins.d/au-prelude.conf fdbe0eae23d0ab3963f81d4102e1cc4b
 /etc/audisp/plugins.d/au-remote.conf 42f29fa17b0da91947b4ac17e1ebf6d4
 /etc/audisp/plugins.d/audispd-zos-remote.conf be9f4b5b737e467a8ff69348a83108e3
 /etc/audisp/zos-remote.conf 871bbe04101ff19cf1baa0dd300c76ec
Description: Plugins for the audit event dispatcher
 The audispd-plugins package provides plugins for the real-time
 interface to the audit system, audispd. These plugins can do things
 like relay events to remote machines or analyze events for suspicious
 behavior.
Homepage: https://people.redhat.com/sgrubb/audit/
Original-Maintainer: Laurent Bigonville <bigon@debian.org>
root@ubuntu:/home/vagrant# 
```

This confirms that `auditd` is installed on my system and complies with the above recommendation.<br ><br >


### 4.2.2.1 Ensure journald is configured to send logs to rsyslog (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 1 - Workstation
### Description:
Data from journald may be stored in volatile memory or persisted locally on the server. Utilities exist to accept remote export of journald logs, however, use of the rsyslog service provides a consistent means of log collection and export.

 Notes:
- This recommendation assumes that recommendation 4.2.1.5, "Ensure rsyslog is configured to send logs to a remote log host" has been implemented.
- As noted in the journald man pages, journald logs may be exported to rsyslog either through the process mentioned here, or through a facility like systemd- journald.service. There are trade-offs involved in each implementation, where ForwardToSyslog will immediately capture all events (and forward to an external log server, if properly configured), but may not capture all boot-up activities. Mechanisms such as systemd-journald.service, on the other hand, will record bootup events, but may delay sending the information to rsyslog, leading to the potential for log manipulation prior to export. 

### Rationale:
Storing log data on a remote host protects log integrity from local attacks. If an attacker gains root access on the local system, they could tamper with or remove log data that is stored on the local system.

### Audit:
Review /etc/systemd/journald.conf and verify that logs are forwarded to syslog with the following command:
`grep -e ForwardToSyslog /etc/systemd/journald.conf`

###### My Output:
```ruby
root@ubuntu:/home/vagrant# grep -e ForwardToSyslog /etc/systemd/journald.conf
#ForwardToSyslog=yes
root@ubuntu:/home/vagrant# 
```
This confirms that `journald` is configured to send logs to rsyslog, and in compliance with the above recommendation.


## 5. ACCESS, AUTHENTICATION AND AUTHORIZATION

### 5.1 Configure time-based job schedulers
cron is a time-based job scheduler used to schedule jobs, commands or shell scripts, to run periodically at fixed times, dates, or intervals.
at provides the ability to execute a command or shell script at a specified date and hour, or after a given interval of time.
> Notes:
- Other methods exist for scheduling jobs, such as systemd timers. If another method is used, it should be secured in accordance with local site policy

### 5.1.1 Ensure cron daemon is enabled and running (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 1 - Workstation

### Description:
The cron daemon is used to execute batch jobs on the system.

> Note: Other methods, such as systemd timers, exist for scheduling jobs. If another method is used, cron should be removed, and the alternate method should be secured in accordance with local site policy

### Rationale:
While there may not be user jobs that need to be run on the system, the system does have maintenance jobs that may include security monitoring that have to run, and cron is used to execute them.

### Audit:
Run the following command to verify cron is enabled:

`systemctl is-enabled cron'

###### My Previous Output:
```ruby
root@ubuntu:/home/vagrant# systemctl status cron
● cron.service - Regular background program processing daemon
     Loaded: loaded (/lib/systemd/system/cron.service; enabled; vendor preset: enabled)
     Active: inactive (dead)
       Docs: man:cron(8)
root@ubuntu:/home/vagrant# 
```
This shows that cron daemon is not enabled and running.

### Remediation:
Run the following command to enable and start cron:

`systemctl --now enable cron`

###### My Final Output:
```ruby
root@ubuntu:/home/vagrant# systemctl status cron | grep 'Active: active (running) '
     Active: active (running) since Fri 2022-09-16 13:06:41 WAT; 4s ago
root@ubuntu:/home/vagrant# 
```
This confirms that `cron daemon` is enabled and running and is in compliance with the above recommendation.


### 5.2 Configure sudo
sudo allows a permitted user to execute a command as the superuser or another user, as specified by the security policy. The invoking user's real (not effective) user ID is used to determine the user name with which to query the security policy.

### 5.2.1 Ensure sudo is installed (Automated)

### Profile Applicability:
- Level 1 - Server
- Level 1 - Workstation

### Description:
sudo allows a permitted user to execute a command as the superuser or another user, as specified by the security policy. The invoking user's real (not effective) user ID is used to determine the user name with which to query the security policy.

> Note: Use the sudo-ldap package if you need LDAP support for sudoers

### Rationale:
sudo supports a plugin architecture for security policies and input/output logging. Third parties can develop and distribute their own policy and I/O logging plugins to work seamlessly with the sudo front end. The default security policy is sudoers, which is configured via the file /etc/sudoers.
The security policy determines what privileges, if any, a user has to run sudo. The policy may require that users authenticate themselves with a password or another authentication mechanism. If authentication is required, sudo will exit if the user's password is not entered within a configurable time limit. This limit is policy-specific.

### Audit:
Verify that sudo in installed.
Run the following command and inspect the output to confirm that sudo is installed:

`dpkg -s sudo`

###### My Output:
```bash
root@ubuntu:/home/vagrant# dpkg -s sudo
Package: sudo
Status: install ok installed
Priority: optional
Section: admin
Installed-Size: 2124
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: arm64
Version: 1.8.31-1ubuntu1.2
Replaces: sudo-ldap
Depends: libaudit1 (>= 1:2.2.1), libc6 (>= 2.27), libpam0g (>= 0.99.7.1), libselinux1 (>= 2.0.65), libpam-modules, lsb-base
Conflicts: sudo-ldap
Conffiles:
 /etc/pam.d/sudo aa40f755f85bb33c9e79bd537e2979be
 /etc/sudoers edcf6528783ecffd3f248c8089dc298e
 /etc/sudoers.d/README 8d3cf36d1713f40a0ddc38e1b21a51b6
Description: Provide limited super user privileges to specific users
 Sudo is a program designed to allow a sysadmin to give limited root
 privileges to users and log root activity.  The basic philosophy is to give
 as few privileges as possible but still allow people to get their work done.
 .
 This version is built with minimal shared library dependencies, use the
 sudo-ldap package instead if you need LDAP support for sudoers.
Homepage: http://www.sudo.ws/
Original-Maintainer: Bdale Garbee <bdale@gag.com>
root@ubuntu:/home/vagrant# 
```
This confirms that `sudo` is installed and in compliance with the above recommendation.

