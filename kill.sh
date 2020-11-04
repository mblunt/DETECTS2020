#!/bin/sh
#Just a utility program for troubleshooting and testing, edit as needed

sensor = pgrep -f sensor.py
sudo kill $sensor


monitor = pgrep -f monitor.sh
sudo kill $monitor


control = pgrep -f control.sh
sudo kill $control