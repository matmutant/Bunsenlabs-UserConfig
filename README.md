# Bunsenlabs-UserConfig
This repository contains my personal scripts and modified config files for my Bunsenlabs netbook in attempt to fit my own needs.

Another intesresting config by oswriter is available [here](http://opensourcewriter.com/how-i-configured-my-bunsenlabs-linux-desktop/).


###Hardware:
######HP EliteBook 2540p
- [x] CPU: Intel(R) Core(TM) i7 CPU       L 640  @ 2.13GHz
- [x] RAM: 2GB (1.82 available for system)
- [x] HDD: Toshiba 160BG, 5400rpm (1.8")
- [x] SSD: Toshiba A100 120GB
- [x] SDcard: 
- [x] OS: Bunsenlabs Hydrogen

## /etc/fstab
As an external SDcard is used as main Data storage, the PC needs to automount it, though it should not fail if the card is not there (using the 'nofail' arg):
```
UUID=[UUID_number]	/media/DataMutant ext4	auto,nofail,noatime,rw,user    0   0
```
##Trim
Enabling trim when using and SSD is advisable to maintain good performance through the SSD life
(Note that in my case swap is also enabled on that SSD which could lead to early wear)

There are a few ways to enable trim. Here I prefered the discontinued way (ie. once a day).

Using the Systemd method needs the following files:

/etc/systemd/fstrim.service (working on Bunsenlabs) or /usr/lib/systemd/system/fstrim.service

==> This file tells where to get the script to launch
```
[Unit]
Description=Discard unused blocks

[Service]
Type=oneshot
ExecStart=/home/matmutant/scripts/trim3.sh
```
/etc/systemd/fstrim.timer (working on Bunsenlabs) or /usr/lib/systemd/system/fstrim.timer

==> this file tells when launching the script
```
[Unit]
Description=Discard unused blocks at boot
Documentation=man:fstrim

[Timer]
OnCalendar=daily
#OnBootSec=1min
AccuracySec=1h
Persistent=true

[Install]
WantedBy=timers.target
```
The script can be placed anywhere, but needs to be pointed by the .service

==> it performs the fstrim, and writes output on a dedicated file (for debugging purpose)

Make sure fstrim is in /sbin/fstrim or modify the path in the script according to its location (```which fstrim```)
```bash
#!/bin/sh
OutputFile="/home/[username]/trim-output"
Touch="/bin/touch"
Date="/bin/date"
Fstrim="/sbin/fstrim"
if [ ! -w "$OutputFile" ]; then
	#if file doesn't exist it is created
	$Touch "$OutputFile"
fi
#appends date to file and then performs trim to / dir
$Date >> "$OutputFile" && $Fstrim -v / >> "$OutputFile"

exit 0
```
Enable the service with:
```
sudo systemctl enable [serviceName].timer
```

##Wifi working at boot without the need of enabling it before shutdown
To get wifi working at boot without tlp workaround, grub needs the following added to kernel parameters:
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet acpi_osi=Linux"
```

##Wifi power save
ath9k.conf file should be placed in /etc/modprobe.d. The following line enables "sudo iw dev wlan0 set power_save on" to work properly
```
options ath9k ps_enable=1
```

##Proxy
To set proxy settings easily, I use [Ubproxy](https://github.com/Sadhanandh/Ubproxy/blob/master/README.md)

##Sound Issue: 
Refer to Head_on_a_Stick tutorial: [here](https://forums.bunsenlabs.org/viewtopic.php?id=2266)  
After following the above tutorial, it might still be necessary to perform the following to avoid Banshee conflicting with Master volume: 

```
echo "flat-volumes = no" >> ~/.config/pulse/daemon.conf
```
Then reboot.  
This will disable "flat volumes" -which enables applications to modify Master volume from their own volume sliders-, now standard Master/Slave behavior will be restored. Thanks to [HoaS](https://forums.bunsenlabs.org/viewtopic.php?id=3252) again for the tip.  

##FIX Xfce4-sxcreenshooter grey screenshot with Compton
Zone screenshots are greyed (shadowed) when took with xfce4-screenshooter when Compositing is enabled

Disabling compositing is NOT a solution, why would you give up shadows? (or use scrot instead)

in ~/.config/compton.conf change 
```
shadow-exclude = [ "i:e:Conky" ];
```
to
```
shadow-exclude = [ "i:e:Conky", "i:e:xfce4-screenshooter" ];
```
Before and  After

![Before](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_ComptonDefault.png)![After](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_ComptonExclude_XfceSS.png)


##Custom username@host and root@host colors in CLI : ~/.bashrc
![Baseline](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_CLI_Colors.png)
```
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
```
line 60:
```
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;47;32m\]\u\[\033[01;30m\]@\[\033[01;90m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```
And for the Root .bashrc
```
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;47;31m\]\u\[\033[01;30m\]@\[\033[01;90m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```
## Tiling
Openbox is not a Tiling WM, but having  some  basic tiling features like vertical/horizontal splitted screen, inverting wich window is on the left/right or top/bottom.  
The following is only the vertical tiling with active window to left (see ![openbox rc.xml](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/openbox/rc.xml) to find the full code).  
```xml
    <!-- Tiling left right-->
    <!-- Vertical tiling active to left-->
    <keybind key="C-A-Left">
      <action name="UnmaximizeFull"/>
      <action name="MaximizeVert"/>
      <action name="MoveResizeTo">
        <width>50%</width>
        <x>0</x>
        <y>0</y>
      </action>
      <!-- Vertical tiling next window to right-->
      <action name="NextWindow">
         <interactive>no</interactive>
         <dialog>none</dialog>
         <finalactions>
           <action name="UnmaximizeFull"/>
           <action name="MoveResizeTo">
             <width>50%</width>
           </action>
           <action name="MaximizeVert"/>
           <action name="MoveResizeTo">
             <x>-0</x>
             <y>0</y>
            </action>
         </finalactions>
      </action>
    </keybind>
```
## Conky
The Default Conky in Bunsenlabs gives nearly everything I needed, though here is a few customisation i did:

Adding acpitemp display and conditionnal colors to the following items: CPU usage, RAM usage, and acpitemp T°C
![lowRAM_MediumTemp_LowCPU](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_lowRAM_MediumTemp_LowCPU_.png.png)![MediumRAM_HighTemp](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_MediumRAM_HighTemp_.png)![lowRAM_HighTemp_HighCPU](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_lowRAM_HighTemp_HighCPU_.png)

### acpitemp conditionnal colors:
Displays Custom colors depending on acpitemp (grey <60°, Orange <70°, red above)
```
T°C:${goto 60}${if_match ${acpitemp}<60}${acpitemp}\
${else}${if_match ${acpitemp}<70}${color orange}${acpitemp}\
${else}${color red}${acpitemp}\
${endif}${endif}${color}°C${alignr}+100°C
```

###CPU usage conditionnal colors
Displays Custom colors depending on CPU usage (grey <50%, Orange <100%, red at 100%)
```
Avg${goto 60}${if_match ${cpu cpu0}<10}  ${cpu cpu0}\
${else}${if_match ${cpu cpu0}<50} ${cpu cpu0}\
${else}${if_match ${cpu cpu0}<100} ${color orange}${cpu cpu0}\
${else}${color red}${cpu cpu0}${endif}${endif}${endif}${color}%${alignr}${freq_g}
```
###RAM usage conditionnal colors
Displays Custom colors depending on RAM usage (grey < 60%, Orange <80%, red above)
```
RAM${goto 60}${if_match ${memperc} <60}${mem}\
${else}${if_match ${memperc} <80}${color orange}${mem}\
${else}${color red}${mem}${endif}${endif}${color}${alignr}${memmax}
Swap${goto 60}${swap}${alignr}${swapmax}
```

###SDcard Auto display usage if plugged in
Displays Data SDCard if plugged in using a simple blank file (named ConkyStarter) present at the root of the card used as Data storage.
```
${if_existing /media/DataMutant/ConkyStarter}SDCard${goto 60}${fs_used /media/DataMutant}${alignr}${fs_size /media/DataMutant}${else}No SDCard${endif}
```

##Tint2 Config (WIP)
See Tint2 Folder for now...


##phwmon.py custom commands
Using [phwomn.py](https://gitlab.com/o9000/phwmon/blob/master/phwmon.py "phwomn.py")
Dependencies: sudo apt-get install python-gtk2 python-psutil;
[Documentation](https://forums.bunsenlabs.org/viewtopic.php?id=967 "Doc")
```
phwmon.py --cpu --mem --fg_mem 555 --fg_cpu d00
```
![phmon](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/scripts/phwmon.png)


##External links:
- [Installing Bunsenlabs on an Acer Aspire One Cloudbook A01-131-C7U3](https://forums.bunsenlabs.org/viewtopic.php?id=2200), and [here](https://github.com/tmlbl/acer-cloudbook-11-bunsenlabs)
