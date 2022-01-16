#!/usr/bin/python3

import sys
#import platform
import Adafruit_DHT
import sqlite3
import time
locationinput = sys.argv[1]
sensorpin = sys.argv[2]

while True:
    now = int(time.time())
    loc = locationinput
    humidity, temperature = Adafruit_DHT.read_retry(Adafruit_DHT.DHT22, sensorpin)
    humidity = "{:.1f}".format(humidity)
    temperature = "{:.1f}".format(temperature)

    db = sqlite3.connect('/home/pi/data/sensordb')
    cursor = db.cursor()
    cursor.execute('''INSERT INTO readings(ReadTime, Location, Temp, Humidity)
                      VALUES(?,?,?,?)''', (now, loc, temperature, humidity))
    db.commit()
    db.close()
    print(temperature)
    time.sleep(120)
