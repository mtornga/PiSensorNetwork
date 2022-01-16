from flask import Flask, request, jsonify, json
import sqlite3
import sys
PiIP = sys.argv[1]

app = Flask(__name__)

def getData():
    conn=sqlite3.connect('/home/pi/data/sensordb')
    curs=conn.cursor()
    for row in curs.execute("SELECT * FROM readings ORDER BY ReadTime DESC LIMIT 1"):
        ReadTime = row[0]
        Location = row[1]
        Temp = row[2]
        Humidity = row[3]
    conn.close()
    return ReadTime, Location, Temp, Humidity

#main route
@app.route("/get_reading", methods=["GET"])
def get_reading():
    ReadTime, Location, Temp, Humidity = getData()
    Payload = {
        'ReadTime': ReadTime,
        'Location': Location,
        'Temp': Temp,
        'Humidity': Humidity
        }
    return jsonify(Payload)


if __name__ == '__main__':
    app.debug=True
    app.run(host= PiIP,port=5005)
    