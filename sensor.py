#!/usr/bin/python

from decimal import *
import time
import py_qmc5883l
import json



sensor = py_qmc5883l.QMC5883L()

#define start_time
start_time = int(time.time())

#Decimal point accuracy
getcontext().prec = 6

while True:

    #+/- 2G FS, meaauring with highest possible accuracy
    sensor.mode_continuous()
           
    #Read our Magnetometer  values
    magRead = sensor.get_magnet()
    magRead = str(magRead).strip('[]')
    Magx, Magy = magRead.split(',')
    Magx = int(float(Magx))
    Magy = int(float(Magy))
    
    #Convert Magnetometer raw to Guass values
    Magx = str(Decimal(Magx) / Decimal(12000)).strip('Decimal')   #12000(LSB)/Guass per datasheet for +/- 2G
    Magy = str(Decimal(Magy) / Decimal(12000)).strip('Decimal')

    #Gather z-axis data (uncalibrated but still interesting)
    zRead = sensor.get_magnet_raw()
    zRead = str(zRead).strip('[]')
    uncalMagx, uncalMagy, Magz = zRead.split(',')
    Magz = int(float(Magz))
    Magz = str(Decimal(Magz) / Decimal(12000)).strip('Decimal')
    
    #Temperature Sensor
    #temp = sensor.get_temp()

    #Current Time
    ctime = time.time()
#Start JSON Packet
    
    #Dictionary
    packet = {
    'id': 'Palmetto Scholars Academy Team 1',
    'data': {
         'Packet Purpose': 'Magnetometer Readings',
         'Magz (uncalibrated)': Magz,
         'Mag-Y': Magy,
         'Mag-X': Magx,
         'Start Time': start_time,
         'Current Time': ctime,
         }
    }

    #Define a variable as a UNIX timestamp
    filename = str(int(time.time()))

    #Makes new file and writes above to it, indent is to make it pretty.
    with open (filename + ".json", "w+") as write_file:
        json.dump(packet, write_file, indent = 4)

    print('success')
    time.sleep(1)