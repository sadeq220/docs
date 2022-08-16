## Disk Image
### A disk image is a computer file containing the complete contents and structure of a data storage device.
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
### .bin, .raw, or .img files are images extracted in pure RAW format.

openssl rand -hex 16 > luksPw
qemu-img create --object secret,id=sec0,file=luksPw -f luks -o key-secret=sec0 encrypted_backup2 27109851136
# create disk Image with luks file format , file name is "encrypted_backup2" and file virtual size is "27109851136 bytes"
# created disk Image is sparse file

qemu-img convert -O raw backupTest.qcow2 /dev/sda4
#recover backup 
qemu-img convert -O raw backupTest.qcow2 backupTest.raw && mount backupTest.raw backupMountPoint/
#you can easily mount raw disk image file

qemu-img create --object secret,id=sec0,file=luksPw -f qcow2 -o encrypt.format=luks,encrypt.key-secret=sec0 backupTest_encrypted.qcow2 2710985113
#create disk Image with qcow2 file format , encrypted with luks

qemu-img info backupTest.qcow2
#show disk Image information

qemu-img convert --object secret,id=sec0,file=luksPw --image-opts driver=qcow2,file.filename=backupTest.qcow2 --target-image-opts driver=qcow2,encrypt.key-secret=sec0,file.filename=backupTest_encrypted.qcow2 -n -p
# encrypt qcow2 disk Image file using luks aes-256-xts

