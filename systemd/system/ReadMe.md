.service and .timer files are meant to be placed in /etc/systemd/system/

The trim3.sh file is meant to be in /home/[userName]/scripts/

Enable the service with:
sudo systemctl enable [serviceName].timer

