# Bunsenlabs-UserConfig
This repository contains my personal scripts and modified config files for my Bunsenlabs netbook in attempt to fit my own needs


## Conky
The Default Conky in Bunsenlabs gives nearly everything I needed, though here is a few customisation i did:
Adding acpitemp display and conditionnal colors to the following items: CPU usage, RAM usage, and acpitemp T°C
![Baseline](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_lowRAM_MediumTemp_LowCPU_.png.png)![Baseline](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_MediumRAM_HighTemp_.png)![Baseline](https://github.com/matmutant/Bunsenlabs-UserConfig/blob/master/misc/Screenshots/Bunsen_lowRAM_HighTemp_HighCPU_.png)

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
