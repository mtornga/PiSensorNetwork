import sqlite3
from sqlite3 import Error


def create_connection(db_file):
    try:
        conn = sqlite3.connect(db_file)
        print(sqlite3.version)
    except Error as e:
        print(e)
    finally:
        conn.close()
        
if __name__ == '__main__':
    create_connection('/home/pi/data/sensordb')

#sqlite3.connect('data/sensordb')
db = sqlite3.connect('/home/pi/data/sensordb')

cursor = db.cursor()
cursor.execute('''
    CREATE TABLE readings(ReadTime INTEGER PRIMARY KEY, Location TEXT,
                          Temp REAL, Humidity REAL) 
''')