## Fedora specific attributes    
Fedora's major differences with Debian include:   
- dnf package manager
- wheel group(instead of sudo group)
- alternatives system(reimplementation of the Debian alternatives system)
- SELinux security architecture
- Flatpak framework

### dnf package manager   
Fedora is a distribution that uses a package management system.   
This system is based on rpm , the RPM Package Manager, with several higher level tools built on top of it, most notably **PackageKit** (default gui) and **DNF**.    
GNOME Software is another GUI package manager.
DNF is a software package manager that installs, updates, and removes packages on Fedora and is the successor to YUM (Yellow-Dog Updater Modified).
```
SYNOPSIS    
dnf [options] <command> [<args>...]

dnf help <command>
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

You can query **RPMDB**(where installed packages reside) directly with rpm tool:
*rpm* is equivalence of *dpkg* in debian-based systems.
```
#put rpm into query mode
rpm {-q|--query}
#to query with wildcard pattern
rpm -qa <pattern>
#to print detailed package information(including installed time)
rpm -qi <package-name> 
```
For example, if you want to list all installed java packages ordered by installation time:
```shell
rpm -qa --last *java*
# to list all packages ordered by their installation time:
rpm -qa --last | less
# to find a package name by its file 
rpm -q -f $(which command)
```
To explore deliberately installed packages (not installed as a dependency)
```shell
dnf repoquery --userinstalled 
```
**package groups**
>A package group is similar to a package: it is not useful by itself, but installing one pulls a group of dependent packages that serve a common purpose.    

package group is set of packages that serve a common purpose.(e.g. KDE-desktop-environment)
A package group has a name and a groupid (GID)
```shell
# to list package group names along with their groupId in parenthesis
dnf group list -v
# to inspect group members
dnf group info -v <groupId>
# to install a group
dnf group install <groupId>
dnf install @<groupId>
# to remove a group
dnf group remove <groupId>
dnf remove @<groupId>
```
### Flatpak framework
>Flatpak is a framework for distributing desktop applications across various Linux distributions.    

Flatpak's applications run in sandboxed environments.
>Flatpak is a tool for managing applications and the runtimes they use. In the Flatpak model,   
> applications can be built and distributed independently from the host system they are used on,    
> and they are isolated from the host system ('sandboxed') to some degree, at runtime.

To get list of installed applications:
```shell
flatpak list
```

### References
- [fedora dnf docs](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)
- [RPM Fusion](https://docs.fedoraproject.org/en-US/quick-docs/rpmfusion-setup/)
- [flatpak docs](https://docs.flatpak.org/en/latest/introduction.html)