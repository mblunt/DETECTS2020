#!/bin/bash

#Change Directory
cd /home/pi/Programs

sudo sh transfer.sh &
sudo sh monitor.sh &
sudo python sensor.py &

#Disable if troubleshooting/testing
#sudo sh UAH_starter.sh &

#log
data > control_log.txt

sleep 720m
sudo shutdown -r 0