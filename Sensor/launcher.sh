#!/bin/sh
#!/usr/bin/python3
#launcher.sh
#navigate to the home directory, then to this directory, then execute python script, then back home
cd /
cd /home/pi/repos/piot
sudo python3 SenseAndWriteToSQLite.py bedroom
sudo python3 PiOTFlask.py 192.168.1.16
cd /
