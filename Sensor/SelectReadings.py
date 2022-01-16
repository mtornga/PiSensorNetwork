import sqlite3

db = sqlite3.connect('/home/pi/data/sensordb')
cursor = db.cursor()

cursor.execute('''SELECT ReadTime, Location, Temp, Humidity FROM readings''')
user1 = cursor.fetchone() #retrieve the first row
print(user1[0]) #Print the first column retrieved(user's name)
all_rows = cursor.fetchall()
for row in all_rows:
    # row[0] returns the first column in the query (name), row[1] returns email column.
    print('{0} , {1}, {2}, {3}'.format(row[0], row[1], row[2], row[3]))
    
db.close()