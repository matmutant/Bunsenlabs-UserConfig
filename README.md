# Bunsenlabs-UserConfig
This repository contains my personal scripts and modified config files for my Bunsenlabs netbook in attempt to fit my own needs.


### Hardware:  
###### PANASONIC FZ-M1 mk3  
- [x] CPU: Intel(R) Core(TM) i5-7Y57  
- [x] RAM: 4GB
- [x] SSD: 128GB
- [x] SDcard: No
- [x] OS: Bunsenlabs Carbon

### Display and scaling  
## DPI setting  
Limiting eye strain with increased item size: set `Xft.dpi=120` in `~/.Xresources`

## Gestures and scrolling
- [Touchegg](https://github.com/joseexposito/touchegg)
- enable one finger scrolling with `export MOZ_USE_XINPUT2=1` so it is possible to navigate instead of selecting.

## Use of Button A for triggering virtual KB
- Modified tbtn driver to support the button ACPI id : MAT0035 ([still under construction](https://github.com/matmutant/tbtn-driver))
- Added keybind ``` "xvkbd" XF86Launch1 ``` to .xbindkeysrc to launch virtual kb on button press

## Rear camera support [WIP]


dmesg outputs :
```
> $ sudo dmesg | grep -i int3472
[    5.901006] int3472-tps68470 i2c-INT3472:05: TPS68470 REVID: 0x21
[    5.901415] int3472-tps68470 i2c-INT3472:05: error -ENODEV: No board-data found for this model
```
&
```
> $ sudo dmesg | grep -i ipu3
[    6.557199] ipu3_imgu: module is from the staging directory, the quality is unknown, you have been warned.
[    6.562099] ipu3-imgu 0000:00:05.0: enabling device (0000 -> 0002)
[    6.562395] ipu3-imgu 0000:00:05.0: device 0x1919 (rev: 0x1)
[    6.562442] ipu3-imgu 0000:00:05.0: physical base address 0x00000000f6000000, 4194304 bytes
[    6.692956] ipu3-cio2 0000:00:14.3: enabling device (0000 -> 0002)
[    6.693315] ipu3-cio2 0000:00:14.3: device 0x9d32 (rev: 0x1)
[    6.755653] ipu3-imgu 0000:00:05.0: loaded firmware version irci_irci_ecr-master_20161208_0213_20170112_1500, 17 binaries, 1212984 bytes
```



checking ACPI tables : 
```sudo cat /sys/firmware/acpi/tables/DSDT > dsdt.bin``` then ```iasl -d dsdt.bin```  
Then ```grep -iE "INT3472|TPS68470|CAM|OV|IMX" dsdt.dsl``` contains the following output : 
```
        Device (CAM0)
            Name (_DDN, "IMX135-CRDG2")  // _DDN: DOS Device Name
                Return (SBUF) /* \_SB_.PCI0.I2C2.CAM0._CRS.SBUF */
                Return (PAR) /* \_SB_.PCI0.I2C2.CAM0.SSDB.PAR_ */
        Device (CAM1)
            Name (_DDN, "OV2740-CRDG2")  // _DDN: DOS Device Name
                Return (SBUF) /* \_SB_.PCI0.I2C4.CAM1._CRS.SBUF */
                Return (PAR) /* \_SB_.PCI0.I2C4.CAM1.SSDB.PAR_ */
            Name (_HID, "INT3472")  // _HID: Hardware ID
            Name (_CID, "INT3472")  // _CID: Compatible ID
```
NB : IMX135-CRDG2 is the 13Mpx CMOS Sony IMX135 rear camera (that is currently not working) & OV2740-CRDG2 is the Omnivision 2Mpx front camera

### TO BE DONE --> NONE OF THE BELOW IS UP TO DATE WITH FZ-M1  
## 
## External links
- [Installing Bunsenlabs on an Acer Aspire One Cloudbook A01-131-C7U3](https://forums.bunsenlabs.org/viewtopic.php?id=2200), and [here](https://github.com/tmlbl/acer-cloudbook-11-bunsenlabs)
