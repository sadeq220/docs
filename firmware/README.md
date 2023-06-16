## Firmware in terms of BIOS and UEFI   
Firmware is a permanent software programmed into a read-only memory(**ROM**) hence the name "firm" .  
Firmware may be written into **ROM**, electrically erasable programmable read-only memory(**EEPROM**), or **flash memory**.   
You can think of firmware as "software for hardware", it serves as an intermediary layer between the hardware and the higher-level software.   
Firmware is responsible for controlling various hardware components, such as processors, memory, input/output devices, sensors, and network interfaces.  
Firmware is usually written in low-level programming languages like *assembly* or *C* or even *Java ME*.   
You can deploy your firmware onto **microcontrollers** like *raspberry PI PICO*.   
Microcontroller is a programmable device for controlling other electronic components, and it communicates with other electronic devices using its **GPIO**.   
Microcontrollers are designed specifically for **Embedded Systems** and are resource-constrained devices.     
### BIOS is motherboard firmware.
Introduction The Basic Input/Output System (BIOS) is a firmware interface present in legacy computer systems.   
This documentation provides an overview of BIOS functionality, highlighting its key features and limitations.   
Features of BIOS:
- Hardware Initialization
   - BIOS is responsible for initializing the computer's hardware components during the boot process.
   - It performs tasks such as identifying and configuring system devices, including the CPU, memory, and peripherals.

- MBR Partition Table
   - BIOS relies on the Master Boot Record (MBR) partitioning scheme to define the disk's partition layout.
   - The MBR is stored in the first sector (sector 0) of the disk and contains the partition table.
   - The MBR partition table allows four(4) primary partitions to be created, with one partition marked as active (bootable).
   - MBR encompasses the 448-byte MBR bootloader code known as **Stage 1 bootloader**.   

- Boot Loader
   - BIOS initiates the boot process by loading and executing the code located in the first sector (MBR) of the bootable device.   
   - The primary bootloader, such as GRUB stage 1, is responsible for loading the secondary bootloader.   

Limitations of BIOS: