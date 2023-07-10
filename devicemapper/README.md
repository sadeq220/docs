### The Device Mapper   
The Device Mapper is a **kernel driver** that provides a framework for volume management.  
It provides a generic way of creating **mapped devices**, which may be used as logical volumes.      
**mapped devices** in Linux are typically **virtual block devices**. They are created to represent or abstract physical block devices, partitions, or other storage components.   
The Device Mapper provides the foundation for a number of higher-level technologies such as LVM , cryptsetup luks , raid.   
The user interface is the `dmsetup` command.    
The Device Mapper supports a variety of **mapping targets** ,   
including **linear mapping**, **striped mapping**, and error mapping.  
So, for example, two disks may be concatenated into one logical volume with a pair of linear mappings, one for each disk.   

### Device Table Mappings   
A mapped device is defined by a table that specifies how to map each range of logical sectors of the device using a supported Device Table mapping.   
```shell
dmsetup ls # list mapped devices
dmsetup table <device>
```
The table for a mapped device is constructed from a list of lines of the form:
```
start length mapping [mapping_parameters...]
```
- *start* is a starting block(sector) in virtual device which must be 0 at the first line.
- *length* is a segment length , it indicates number of sectors for this segment.   

mapping parameters are specified in a line of the mapping table depends on which **mapping type** is specified on the line.   
for example "0 4161536 crypt aes-xts-plain64 :64:logon:cryptsetup:3ff6b0f6-7d7e-4fe7-b24a-94d2294f43e3-d0 0 8:33 32768"      
preceding table contains only one line , and contained information are :
- mapped device contains 416536 * 512 bytes size. ( length * sector )
- **mapping type/target** is *crypt* 
- this line also specified a device in its mapping parameters as *8:33* which is in format of **major:minor**.    

### References
[redhat doc](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/device_mapper)