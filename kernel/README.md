## Linux Kernel   
The kernel is a core part of a Linux operating system that manages the system resources and,     
provides interface between hardware and software applications.
Red Hat minimum kernel installation, includes these packages:    
- kernel (the kernel meta package)
  - kernel-core(contains vmlinuz)
  - kernel-modules-core
  - kernel-modules(not necessary for virtualized and cloud environments)

debian minimum kernel installation, includes this package:
  - linux-image-<version>-<platform>

## vmlinuz    
vmlinuz is the compressed, bootable Linux kernel image.    
The name is derived from "Virtual Memory LINUx gZip," indicating that it is a gzip-compressed Linux kernel.   
The vmlinuz files usually reside in the */boot* directory.    
During the boot process, the bootloader (such as GRUB2) loads the vmlinuz file into memory, and the kernel takes control of the system.    
It initializes hardware, mounts the root filesystem, and starts the system's user-space processes.    

## Kernel space - user space
**Virtual memory address space separation for memory protection and hardware protection**     
> The kernel space is the memory area that is reserved to the kernel while user space is the memory area reserved to a particular user process.  

`Virtual address space`: the way the CPU sees the memory when the virtual memory module is activated.    
Each user space process normally runs in its own virtual memory address space    
`System calls`: kernel service interface which cause execution mode switch from user mode to kernel mode.     

## Kernel modules
- Without modules, we would have to build monolithic kernels and add new functionality directly into the kernel image.
- A kernel module is a code (C language) that can be loaded into the kernel image at will, without requiring users to rebuild the kernel or reboot their computer
- A module can be configured as built-in or loadable.
- To dynamically load or remove a module, it has to be configured as a loadable module in the kernel configuration (the line related to the module will therefore display the letter `M`).
- Most of the device drivers are used in the form of kernel modules.
- kernel modules usage :
	- `Device driver` which adds support for new hardware
	- File system driver, support for a file system such as GFS2 or NFS
	- network protocol
	- system call
- Kernel modules have a `.ko` extension as of kernel 3.0. 
- On Red Hat Enterprise Linux 8, kernel modules are extra kernel code which is built into compressed <KERNEL_MODULE_NAME>.ko.xz object files.       
- A character device is one of the simplest ways to communicate with a module in the Linux kernel.
- the character device drivers receive unaltered system calls made by users over device-type files(not altered by VFS)
- To determine loaded modules run the command lsmod
```shell
lsmod
```
- To show information about a module: 
```shell
modinfo <module_name>
```
- Kernel modules are handled by tools provided by `kmod` package
```shell
dpkg --listfiles kmod
```
- To load a module
```shell
modprobe <module_name>
```
- To unload a module
```shell
modprobe -r <module_name>
```
- To load a module at boot time    
> [!WARNING]
> The code of kernel modules is executed in kernel-space in the unrestricted mode.    
> Because of this, you should be mindful of what modules you are loading.    
```shell
echo <MODULE_NAME> > /etc/modules-load.d/<MODULE_NAME>.conf
```
- LKMs(Loadable Kernel Modules) are located in
```shell
# /lib is symlink to /usr/lib 
ls /usr/lib/modules/$(uname -r)/kernel
```


## Refrences
- [Red Hat kernel doc](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/managing_monitoring_and_updating_the_kernel/index)
- [Arch wiki:kernel modules](https://wiki.archlinux.org/title/Kernel_module)
- [wiki books:the linux kernel modules](https://en.wikibooks.org/wiki/The_Linux_Kernel/Modules)
- [tldp.org:introduction to LKM](https://tldp.org/HOWTO/Module-HOWTO/x73.html)
- [dev.to vmlinuz](https://dev.to/er_dward/understanding-the-initrd-and-vmlinuz-in-linux-boot-process-534f)
- [kernel space](https://linux-kernel-labs.github.io/refs/heads/master/lectures/intro.html)
- [system calls](https://linux-kernel-labs.github.io/refs/heads/master/lectures/syscalls.html)
