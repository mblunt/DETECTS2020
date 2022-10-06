#!/bin/bash
#Written by Michael Blunt from Palmetto Scholars Academy High School
#Written as part of DETECTS program for the University of Alabama at Huntsville's ACES RED 2 B Program
#I have included many comments, I hope they will make the code (and its associated purpose) more legible and easy to understand
#---DISCLAIMER---
#I am not a professional, this code was written to the best of my abilities. I offer no guarentees with this code.

#Give time for programs to launch, and if monitor program restarts things that are not broken, provide enough of a buffer time not to harm experiment data collection.
sleep 20m


i="0"

while [ $i -lt 100 ]
do
#All of the below code is to verify to all programs are looping properly

#Store log files data in a corresponding variable
startup_log=$(cat /home/pi/Programs/startup_log.txt)
transfer_log=$(cat /home/pi/Programs/transfer_log.txt)
UAH_starter_log=$(cat /home/pi/Programs/UAH_starter_log.txt)
sensor_log=$(cat /home/pi/Programs/sensor_log.txt)

#Current time for comparison to log data
current_time=$(date)

#Split the log files' strings into usable data
startup_date=${startup_log:4:2}
startup_hour=${startup_log:16:2}
startup_am_pm=${startup_log:25:2}

transfer_minute=${transfer_log:19:2}

UAH_starter_date=${UAH_starter_log:4:2}
UAH_starter_hour=${UAH_starter_log:16:2}
UAH_starter_am_pm=${UAH_starter_log:25:2}

sensor_date=${sensor_log:4:2}
sensor_hour=${sensor_log:16:2}
sensor_am_pm=${sensor_log:25:2}




#STARTUP CHECKER#
if [[ "$startup_date" == ${current_time:4:2} ]] || [[ "$startup_date" == "$(${current_time:4:2} - 1)" ]] || [[ "$startup_date" == "$(${current_time:4:2} + 1)" ]]; then
	echo "startup date good"
else
	echo "startup date fail"
	shutdown -r 0
fi
if [[ "$startup_hour" == ${current_time:16:2} ]]; then  #Evaulates to true if the start hours are the same, ex: started 08:12, current time is 08:23, evaluates to true.
	if [[ "$startup_am_pm" == ${current_time:25:2} ]]; then  #makes sure that startup is within 12 hour cycle, ex: 08:12am and 08:23am would evaluate to true, 08:12am and 08:34pm would evaluate to false.
		echo "startup.sh ran less than 1 hour ago"
	else
		echo "startup hour fail"
		shutdown -r 0 #The very first time this is run, it will actually cut the startup program's 12 hour cycle short. Consider the log value of 08:46am, the monitor program would trigger this restart at 8:00pm
	fi
else
	echo "startup.sh started less than 12 hours ago" #Because this is a 12 hour cycle, the restart will never need to occur in a different hour than the program was launched in.
fi




#TRANSFER CHECKER#
if [[ "$transfer_minute" == ${current_time:19:2} ]] || [[ "$transfer_minute" == "$((${current_time:19:2} - 2))" ]] || [[ "$transfer_minute" == "$((${current_time:19:2} + 2))" ]]; then  #Within acceptable deviation
	echo "transfer looping good"
else
	echo "transfer loop fail"
	shutdown -r 0
fi




#UAH PROGRAM CHECK#
if [[ "$UAH_starter_date" == ${current_time:4:2} ]] || [[ "$UAH_starter_date" == "$((${current_time:4:2} - 1))" ]] || [[ "$UAH_starter_date" == "$((${current_time:4:2} + 1))" ]]; then
	echo "UAH starter good"
else
	echo "UAH date fail"
	shutdown -r 0
fi
if [[ "$UAH_starter_hour" == ${current_time:16:2} ]]; then
	if [[ "$UAH_starter_am_pm" == ${current_time:25:2} ]]; then
		echo "UAH starter ran less than 1 hour ago"
	else
		echo "UAH hour fail"
		shutdown -r 0
	fi
else
	echo "UAH starter started less than 12 hours ago" #Because this is a 12 hour cycle, the restart will never need to occur in a different hour than the program was launched in.
fi




#SENSOR CHECK#
if [[ "$sensor_date" == ${current_time:4:2} ]] || [[ "$sensor_date" == "$((${current_time:4:2} - 1))" ]] || [[ "$sensor_date" == "$((${current_time:4:2} + 1))" ]]; then
	echo "sensor date good"
else
	echo "sensor date fail"
	shutdown -r 0
fi
if [[ "$sensor_hour" == ${current_time:16:2} ]]; then
	if [[ "$sensor_am_pm" == ${current_time:25:2} ]]; then
		echo "sensor started less than 1 hour ago"
	else
		echo "sensor hour fail"
		shutdown -r 0
	fi
else
	echo "sensor started less than 12 hours ago" #Because this is a 12 hour cycle, the restart will never need to occur in a different hour than the program was launched in. DO NOT CHANGE TO MILITARY/24HR CLOCK!!! 
fi

sleep 10m
done