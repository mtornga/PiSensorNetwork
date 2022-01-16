# PiOT

Creating some IoT-type devices for around the house and having them report back to a main node. The current thrust of PiOT collects temperature and humidity data.

Result
![GrafanaExample](HomeBase/GrafanaExample.png)

Architecture:


Technologies Demonstrated:

 - Docker
	 - Creating containers in a network
	 - Automating deployment of the stack
	 - Exposing ports to localhost
 - MySQL
	 - Database and table creation
	 - Light ETL
	 - Event manager for scheduling actions
 - Nifi
	 - InvokeHTTP for scheduling HTTP GET requests
	 - PutDatabaseRecord for converting JSON into INSERT statements
	 - Processor templating
 - Python3
	 - Flask for hosting a RESTful API
	 - Command-line arguments
	 - Writing to a SQLite database
 - SQLite
 - Crontab
 - DH22 Sensor

# Deploying on a new Pi

Deployed and tested on Raspberry Pi versions 3b+, 4, and Zero W with the full Raspian installation.

## Preparing the Raspian environment

Raspian was installed using the NOOBS thing where the OS is loaded on the SIM card for the user. I will try to script the installation of these other pre-reqs:
- Python3
- Adafruit DHT
- Git

sudo apt update
sudo apt-get update && sudo apt-get upgrade -y (something like this)
sudo apt-get install python3
sudo apt-get install git
mkdir repos && cd repos
git clone https://MarkTornga@bitbucket.org/MarkTornga/piot.git
mkdir /home/pi/data
then run CreateSensorDB

installing adafruit dht stuff
sudo python3 -m pip install --upgrade pip setuptools wheel 
sudo pip3 install Adafruit_DHT
git clone https://github.com/adafruit/Adafruit_Python_DHT.git
sudo python3 setup.py install


Run pinout to get the GPIO info and then attach the sensor.
Plus to power, minus to ground, out to a GPIO pin

Enable ssh access:
sudo systemctl enable ssh
sudo systemctl start ssh

Assign static IP


# Setting up the home base
In nifi, have to upload template, add template to tthe canvas,
in DBCPConnectionPool controller service:
Databse connection URL will need to do docker inspect network web to find the ip for the finaldb container
have to set the password parameter
