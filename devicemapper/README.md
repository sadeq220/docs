### The Device Mapper   
The Device Mapper is a **kernel driver** that provides a framework for volume management.  
It provides a generic way of creating mapped devices, which may be used as logical volumes.   
The Device Mapper provides the foundation for a number of higher-level technologies such as LVM , cryptsetup luks , raid.   
The user interface is the `dmsetup` command.    
The Device Mapper supports a variety of **mapping targets** ,   
including **linear mapping**, **striped mapping**, and error mapping.  
So, for example, two disks may be concatenated into one logical volume with a pair of linear mappings, one for each disk.   

### Device Table Mappings   
A mapped device is defined by a table that specifies how to map each range of logical sectors of the device using a supported Device Table mapping.   
```shell
dmsetup table <device>
```

### References
[redhat doc](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/logical_volume_manager_administration/device_mapper)