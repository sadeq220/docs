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
Third-party software repositories contains packages that are not officially affiliated by the fedora project(e.g. vlc).    
**RPM Fusion** is the most commonly used third-party repository, to enable it:
```shell
 sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
```
To disable *RPM Fusion* repository:
```shell
dnf config-manager --set-disabled rpmfusion-free
#to confirm 
dnf repolist --all
#to enable it
dnf config-manager --set-enabled rpmfusion-free
```
### References
- [fedora dnf docs](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)
- [RPM Fusion](https://docs.fedoraproject.org/en-US/quick-docs/rpmfusion-setup/)