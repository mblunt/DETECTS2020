#!/bin/bash
#Runs as user, do not run as root. Change relative paths to be absolute paths in the future.


a=0
while [ "$a" -lt 100 ] 
do

    #Change Directory
    cd ~/Programs
    
    sleep 1

    #make directory
    mkdir /tmp/experiment

    #Move files
    mv ~/*.json /tmp/experiment/ 
    mv ~/Programs/*.json /tmp/experiment/ 

    #append current time to log
    echo "Transfer Program running as of: $(date)." > ~/Programs/transfer_log.txt
done
