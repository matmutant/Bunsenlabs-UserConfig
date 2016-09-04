# Bunsenlabs-UserConfig
This repository contains my personal scripts and modified config files for my Bunsenlabs netbook in attempt to fit my own needs

## /etc/fstab
As an external SDcard is used as main Data storage, the PC needs to automount it, though it should fail if the card is not there (using the 'nofail' arg):
```
UUID=[UUID_number]	/media/DataMutant ext4	auto,nofail,noatime,rw,user    0   0
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
To set proxy settings easily, I use ![Ubproxy](https://github.com/Sadhanandh/Ubproxy/blob/master/README.md "Ubproxy"]


###Custom username@host and root@host colors in CLI : ~/.bashrc
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

##phwmon.py custom commands
using [phwomn.py](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/scripts/phwmon.py "phwomn.py")
```
phwmon.py --cpu --mem --fg_mem 555 --fg_cpu d00
```
![phmon](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/scripts/phwmon.png)
