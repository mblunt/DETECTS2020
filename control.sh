#!/bin/bash

#Change Directory
cd ~/Programs

#ampersand runs programs in background
sh transfer.sh &
sh monitor.sh &
#python sensor.py &

#Disable if troubleshooting/testing
#sudo sh UAH_starter.sh &

#log
echo "Control Program last run at: $(date)." > ~/Programs/transfer_log.txt

sleep 720m
sudo shutdown -r 0
