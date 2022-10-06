#!/bin/bash

#By Michael Blunt

sleep 2m

integer = '[0-9]'

#Check PID exists for Magnet Program
magnet = sudo pgrep -f 'magnet.py'

if ! [[ $magnet =~ $integer]] ; then
	sudo kill $(pgrep -f 'magnet.py')
	sudo kill $(pgrep -f 'sensor.py')
	sudo kill $(pgrep -f 'control.sh')
	#sudo kill $(pgrep -f 'transfer.sh')
	#troubleshooting
	touch /home/pi/Desktop/magnetfail.txt
	#sudo shutdown -r 0
fi

#Check PID exists for Sensor Program
sensor = sudo pgrep -f 'sensor.py'

if ! [[$sensor =~ $integer]] ; then
	#sudo kill $(pgrep -f 'magnet.py')
	sudo kill $(pgrep -f 'sensor.py')
	sudo kill $(pgrep -f 'control.sh')
	#sudo kill $(pgrep -f 'transfer.sh')
	#troubleshooting
	touch /home/pi/Desktop/sensorfail.txt
	#sudo shutdown -r 0
fi

#Check PID exists for Control Program
control = sudo pgrep -f 'control.sh'

if ! [[$control =~ $integer]] ; then
	#sudo kill $(pgrep -f 'magnet.py')
	sudo kill $(pgrep -f 'sensor.py')
	sudo kill $(pgrep -f 'control.sh')
	#sudo kill $(pgrep -f 'transfer.sh')
	#troubleshooting
	touch /home/pi/Desktop/controlfail.txt
	#sudo shutdown -r 0
fi

#Check PID exists for Transfer Program
transfer = sudo pgrep -f 'transfer.sh'

if ! [[$transfer =~ $integer]] ; then
	#sudo kill $(pgrep -f 'magnet.py')
	sudo kill $(pgrep -f 'sensor.py')
	sudo kill $(pgrep -f 'control.sh')
	#sudo kill $(pgrep -f 'transfer.sh')
	#troubleshooting
	touch /home/pi/Desktop/transferfail.txt
	#sudo shutdown -r 0
fi

#loop
/bin/sh /home/pi/monitor.sh
 
