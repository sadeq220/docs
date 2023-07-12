## fedora specific attributes  
Fedora is a distribution that uses a package management system.   
This system is based on rpm , the RPM Package Manager, with several higher level tools built on top of it, most notably **PackageKit** (default gui) and **DNF**.    
GNOME Software is another GUI package manager.
- dnf package manager
- SELinux security architecture

### dnf package manager   
DNF is a software package manager that installs, updates, and removes packages on Fedora and is the successor to YUM (Yellow-Dog Updater Modified).
DNF package repositories reside in "/etc/yum.repos.d/" directory.
```shell
dnf config-manager --add-repo <URL> 
dnf repolist 
```

### References
- [fedora dnf docs](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)