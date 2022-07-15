## Kernel modules
- Without modules, we would have to build monolithic kernels and add new functionality directly into the kernel image.
- A kernel module is a code (C language) that can be loaded into the kernel image at will, without requiring users to rebuild the kernel or reboot their computer
- A module can be configured as built-in or loadable.
- To dynamically load or remove a module, it has to be configured as a loadable module in the kernel configuration (the line related to the module will therefore display the letter `M`).
- Most of the device drivers are used in the form of kernel modules.
- Kernel modules have a `.ko` extension as of kernel 3.0. 
- A character device is one of the simplest ways to communicate with a module in the Linux kernel.
- the character device drivers receive unaltered system calls made by users over device-type files(not altered by VFS)
- To determine loaded modules run the command lsmod
```shell
lsmod
```


## Refrences
- [Arch wiki:kernel modules](https://wiki.archlinux.org/title/Kernel_module)
- [wiki books:the linux kernel modules](https://en.wikibooks.org/wiki/The_Linux_Kernel/Modules)
