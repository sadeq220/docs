## Fedora specific attributes    
Fedora's major differences with Debian include:   
- dnf package manager
- wheel group(instead of sudo group)
- alternatives system(reimplementation of the Debian alternatives system)
- SELinux security architecture

### dnf package manager   
Fedora is a distribution that uses a package management system.   
This system is based on rpm , the RPM Package Manager, with several higher level tools built on top of it, most notably **PackageKit** (default gui) and **DNF**.    
GNOME Software is another GUI package manager.
DNF is a software package manager that installs, updates, and removes packages on Fedora and is the successor to YUM (Yellow-Dog Updater Modified).
```
SYNOPSIS    
dnf [options] <command> [<args>...]
```
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
**dnf list command**
> A package is installed if it is present in the RPMDB,       
> and it is available if it is not installed but is present in a repository that DNF knows about.   

```shell
dnf list [--installed|--available|--all] [<package-file-spec>...]
```
**dnf upgrade command**
Updates each specified package to the latest available version.
```
Upgrade Command
       Command: upgrade
       Aliases: up
       Deprecated aliases: update, upgrade-to, update-to, localupdate
```
Note that update is an alias for upgrade command.
:white_check_mark: dnf upgrade = dnf update :white_check_mark:
### References
- [fedora dnf docs](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)
- [RPM Fusion](https://docs.fedoraproject.org/en-US/quick-docs/rpmfusion-setup/)