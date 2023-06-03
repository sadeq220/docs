## Disk Image
### A disk image is a computer file containing the complete contents and structure of a data storage device.
### A disk image is usually made by creating a sector-by-sector copy of the source medium 
### usage : 
 - backup and recovery
 - remote distribution of software such as Linux distributions ( .iso files )
 - virtual disk drive space to be used by SystemVirtualization ( .qcow2 .vdi )
### Disk cloning is the process of making an image of a partition or of an entire hard drive

- block-level image
	- dd command
- fs-aware image
	- e2image -a 
	- xfs_copy
>*NOTE*: .bin, .raw, or .img files are images extracted in pure RAW format .

>**qcow2**
>##### I found `qcow2` format most versatile disk image format that supports encryption , compression ,and snapshots.
>##### `qcow2` format also has a smaller size cause it wont include unused bytes ( holes )
>##### KVM and QEMU already using this format for their virtualization disk image
>##### QEMU is a generic and open source machine emulator and virtualizer.
>##### QEMU also provides a number of standalone commandline utilities, such as the `qemu-img` disk image utility that allows you to create, convert and modify disk images.   

### create disk Image with `luks file format` , file name is "encrypted_backup2" and file virtual size is "27109851136 bytes"
> created disk Image is a sparse file
```sh
openssl rand -hex 16 > luksPw
qemu-img create --object secret,id=sec0,file=luksPw -f luks -o key-secret=sec0 encrypted_backup2 27109851136
```
<div id="create-encrypted-qcow2" />

### create disk Image with qcow2 file format , encrypted with luks
```sh
qemu-img create --object secret,id=sec0,file=luksPw -f qcow2 -o encrypt.format=luks,encrypt.key-secret=sec0 backupTest_encrypted.qcow2 2710985113
```
### recover backup 
```sh
qemu-img convert -O raw backupTest.qcow2 /dev/sda4
```
### you can easily mount raw disk image file
```sh
qemu-img convert -O raw backupTest.qcow2 backupTest.raw && mount backupTest.raw backupMountPoint/
```
### show disk Image information
```sh
qemu-img info backupTest.qcow2
```
### encrypt qcow2 disk Image file using luks aes-256-xts   
You should create an empty encrypted qcow2 disk image with exact size of unencrypted one first [how_to](#create-encrypted-qcow2) (e.g. "backupTest_encrypted.qcow2" in this example)   
You should Erase the unencrypted image securely using `shred` after converting it to encrypted image.
```sh
qemu-img convert --object secret,id=sec0,file=luksPw --image-opts driver=qcow2,file.filename=backupTest.qcow2 --target-image-opts driver=qcow2,encrypt.key-secret=sec0,file.filename=backupTest_encrypted.qcow2 -n -p
shred -vzu backupTest.qcow2 
```
### How to mount a qcow2 formatted image ?   
use Network Block Device (NBD) and command utility called `qemu-nbd`   
**Step 1 - Load NBD kernel module with max_part module parameter**
```shell
modprobe mbd max_part=8
```
**Step 2 - Connect the encrypted QCOW2 as network block device**
```shell
qemu-nbd --object secret,id=sec0,file=luksPassphrase --image-opts driver=qcow2,encrypt.key-secret=sec0,file.filename=testingDiskImg_encrypted.qcow2 --connect=/dev/nbd0
```
**Step3 - List disk image block devices ( partitions are also block devices )**
```shell
lsblk /dev/nbd0
```
**Step4 - Mount the desired block device (e.g. nbd0p1 , nbd0 )**
```shell
mount /dev/nbd0 /mnt/mountPoint
```
**Step5 - Unmount and disconnect the device**
```shell
umount /mnt/mountPoint
qemu-nbd --diconnect /dev/nbd0
modprobe -r nbd 
```