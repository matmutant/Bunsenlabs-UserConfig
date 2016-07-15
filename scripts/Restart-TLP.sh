#!/bin/bash
echo "Welcome to Restarting TLP Script"
echo
echo -e "Current CPU governor status\033[1;32m"
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo
echo -e "\033[0;0mRestarting TLP to refresh Power-Saving"
sudo service tlp stop
#sudo sed 's/TLP_ENABLE=0/TLP_ENABLE=1/' </etc/default/tlp2 >/etc/default/tlp2
sudo service tlp start
echo "Restarting TLP"
echo
sleep 5
echo -e "New CPU governor status\033[1;32m"
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo
echo -e "\033[0;0mTLP has been restarted"
sleep 10
exit 0
