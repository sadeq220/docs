## Fedora specific attributes    
Fedora's major differences with Debian include:   
- dnf package manager
- wheel group(instead of sudo group)
- alternatives system(reimplementation of the Debian alternatives system)
- Flatpak framework
- firewalld
- SELinux security architecture

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
What dnf command refers to in different Fedora versions:

| Fedora version   | dnf command |
|------------------|-------------|
| 36-40(inclusive) | dnf-3       |
| 41+              | dnf-5       |

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
To display the list of files in a package(without installation):
```shell
dnf repoquery -l <package-name>
# or if package reside in RMPDB
rpm -q --list <package-name>
```
To run commands on top of all packages in given repository
```shell
dnf-3 repository-packages <repo-id> <sub-command>
# sub-commands include: list, install, remove, info
# for example to install all docker-ce repository packages
dnf-3 repository-packages docker-ce-stable install
```
To install alternative package(and remove the old conflicting package)
```shell
dnf swap <remove-spec> <install-spec>
# for example to install the full ffmpeg
# --allowerasing for Automatic conflict  solving
dnf swap ffmpeg-free ffmpeg --allowerasing
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
**dnf modularity**    
>Modules are special package groups usually representing an application, a language runtime, or a set of tools.      
> They are available in one or multiple streams which usually represent a major version of a piece of software, giving you an option to choose what versions of packages you want to consume.     


> Simply put, modulemd is a file that defines which packages get built for which releases.      
> It includes a summary and a description, a list of source RPM packages, build information i.e. build order and macros, and usage information i.e. installation profiles and licenses.     

module: Packages are grouped into modules — a representation of an application, a language runtime, or any logical group.    
module streams: Stream  is  a  collection  of  packages, a virtual repository. It is identified with Name and Stream from modulemd separated with colon, for example "postgresql:9.6".     

>Module streams can be active or inactive. active means the RPM packages from this stream are included in  the  set  of  available packages.      
> Packages  from  inactive streams are filtered out.  Streams are active either if marked as default or if they are explicitly enabled by a user action.      
> Streams that satisfy dependencies of default or enabled streams are  also  considered  active.     
> Only one stream of a particular module can be active at a given point in time.

```shell
#to list available module streams
dnf module list nginx
#to enable a module stream
dnf module enable Name:Stream
# for example
dnf module enable nginx:mainline
```

after enabling a module stream its packages become available for installation.     
```shell
dnf install nginx
```
### bash completion
To provide bash completion in Linux, simply install bash-completion package.     
```shell
dnf install bash-completion
```
Installer places a script called `/etc/profile.d/bash_completion.sh`.     

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
### grubby
To switch between kernels, or change kernel command-line args this tool comes handy.    
grubby changes `GRUB 2` bootloader config files.    
To list all boot entries:   
```shell
grubby --info ALL
```
To view a default boot entry:
```shell
grubby --info DEFAULT
```
To set a default kernel:
```shell
grubby --set-default /boot/vmlinuz-<version>.<architecture>
```
### firewalld
While Debian-based systems often use UFW for packet filtering, Red Hat-based systems use `firewalld`.    
> firewalld is a firewall service daemon that provides a dynamic customizable host-based firewall with a D-Bus interface.

A firewall zone defines the trust level for a connection, interface or source address binding.

> firewalld uses the concepts of zones and services, that simplify the traffic management.      
> Zones are predefined sets of rules.      
> Network interfaces and sources can be assigned to a zone.     

In firewalld **nftables** is the default backend and not *iptables*.     
> nftables in a replacement for all of; iptables, ip6tables, arptables, ebtables, and ipset (henceforth know as “iptables and family”)     

use `nft` binary to examine *nftables*, for example
```shell
nft list tables
nft list ruleset
```
firewalld blocks all traffic on ports that are not explicitly set as open. Some zones, such as trusted, allow all traffic by default.      
firewalld CLI is `firewall-cmd`.     
To check firewalld daemon status
```bash
systemctl status firewalld

firewall-cmd --state
```
To check available zones and active zones
```shell
firewall-cmd --get-zones
firewall-cmd --get-active-zones
```
To list all rules in a specific zone
```shell
firewall-cmd --zone=<zoneName> --list-all
```
> When interface connections are added to NetworkManager, they are assigned to the default zone.     

To change NetworkManager connection zone
```shell
nmcli connection modify <con-name> connection.zone <zone-name>
```
firewalld denies interzone traffic (from zone to zone) by default.     

### SELinux(Security-Enhanced Linux)
SELinux is an implementation of MAC(Mandatory Access Control) which is an enhancement over DAC (Discretionary Access Control).     
DAC is the standard access policy based on the user, group, and other permissions. i.e. access that controlled by *chown* and *chmod* commands.    
The problem with DAC is that every process a user executes can access and modify all files owned by that user, so minimal protection is provided against malicious software.    
SELinux addresses this coarse-grained privileges.     
> Security-Enhanced Linux (SELinux) is an implementation of a mandatory access control mechanism in the Linux kernel,    
> checking for allowed operations after standard discretionary access controls are checked.

SELinux fundamentally answers the question: "May <subject>(process) do <action> to <object>(file)".   

### References
- [fedora dnf docs](https://docs.fedoraproject.org/en-US/quick-docs/dnf/)
- [RPM Fusion](https://docs.fedoraproject.org/en-US/quick-docs/rpmfusion-setup/)
- [flatpak docs](https://docs.flatpak.org/en/latest/introduction.html)
- [fedora grub2 wiki](https://fedoraproject.org/wiki/GRUB_2)
- [fedora multimedia](https://rpmfusion.org/Howto/Multimedia)
- [fedora modularity](https://docs.fedoraproject.org/en-US/modularity/using-modules/)
- [redhat firewalld](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/using-and-configuring-firewalld_configuring-and-managing-networking#using-and-configuring-firewalld_configuring-and-managing-networking)
- [firewalld nftables](https://firewalld.org/2018/07/nftables-backend)
- [redhat SELinux](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/security-enhanced_linux/chap-security-enhanced_linux-introduction#chap-Security-Enhanced_Linux-Introduction)