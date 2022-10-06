'''
Created by Michael Blunt

This program runs and outputs data to a transfer program written in bash
For use on a Grove 1.1 Electromagnet with a Raspberry Pi3B+

Pin Configuration:
WiringPi 0 = Secondary Line
WiringPi 1 = Primary Data Line
Physical Pin 2 = 5v Power Supply, can be changed to 3.3v if needed
Physical Pin 14 = Ground

Notes:
Print Statements are for troubleshooting and testing, will be removed in final revision
The time in the 'magnet off' sleep statement is short just for testing purposes
THE MAGNET DOES NOT TURN OFF WHEN THE PROGRAM IS CLOSED, EXIT THE PROGRAM DURING A 'magnet off' CYCLE!!!

4-12-20
v2.2
'''

import wiringpi as gpio
import time
import json
import subprocess
import sys

gpio.wiringPiSetupGpio()
gpio.pinMode(1, 1)

start_time = int(time.time())

while True:
    gpio.digitalWrite(1, 1)

    try:
        #Magnet Cycle Start
        gpio.digitalWrite(1, 1)
        magnetPower = 'on' 
        time.sleep(30)
        IOState = 'normal'

        gpio.digitalWrite(1, 0)
        magnetPower = 'off'         
        time.sleep(180)
        time_elapsed = time.time() - start_time
        time_elapsed = int(time_elapsed)
        #Magnet Cycle End

        #Package Data into File
        timestamp = str(int(time.time()))
        file = str('{}.json').format(timestamp)

            #Defines Packet Purpose/Sends Mag OK data
        magnetStatus = {
        'id': 'Palmetto Scholars Academy Team 1',
        'data': {
            'Packet Purpose': 'Magnet Status',
	    'Electromagnet IOState:': IOState,
            'Electromagnet Power State:': magnetPower,
            'Electromagnet Start Time:': start_time,
            'Electromagnet Running Time:': time_elapsed,
            }
        }

        with open(file, 'w+') as write_file:
            json.dump(magnetStatus, write_file, indent = 4)

    except IOError:
        IOState = 'error'
        gpio.digitalWrite(1, 0)
        magnetPower = 'off'

        #Package Data into File
        timestamp = str(int(time.time()))
        file = str('{}.json').format(timestamp)

        magnetStatus = {
        'id': 'Palmetto Scholars Academy Team 1',
        'data': {
            'Packet Purpose': 'Magnet Status',
	    'Electromagnet IOState:': IOState,
            'Electromagnet Power State:': magnetPower,
            'Electromagnet Start Time:': start_time,
            'Electromagnet Running Time:': time_elapsed,
            }
        }

        with open(file, 'w+') as write_file:
            json.dump(magnetStatus, write_file, indent = 4)
       

        #Start Shutdown process
        subprocess.call(['./kill.sh'])

