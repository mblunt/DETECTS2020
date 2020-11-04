#!/bin/bash

a=0
while [ "$a" -lt 100 ] 
do

    #Change Directory
    cd /home/pi/Programs

    sleep 1

    #make directory
    mkdir /tmp/experiment

    #Move files
    mv ~/home/pi/*.json /tmp/experiment/ 
    mv ~/home/pi/Programs/*.json /tmp/experiment/ 

    #log
    date > ~/home/pi/Programs/transfer_log.txt
done