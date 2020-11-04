#!/bin/sh

#Start the sender
sudo /home/pi/Programs/raspberry-pi-team-sender

#Remove and replace log
sudo rm ~/home/pi/Programs/downlog.txt

#append program timestamp to monitor log file
date > ~/home/pi/Programs/downlog.txt


