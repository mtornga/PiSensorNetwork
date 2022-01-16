CREATE DATABASE lz;
CREATE USER 'mark'@'%' IDENTIFIED BY 'bobs';
GRANT ALL PRIVILEGES ON lz.* TO 'mark'@'%' WITH GRANT OPTION;
USE lz;
#Added this primary key
CREATE TABLE IF NOT EXISTS sensor_raw (Humidity FLOAT, Location VARCHAR(255), ReadTime INT, Temp FLOAT, PRIMARY KEY (ReadTime));
CREATE TABLE IF NOT EXISTS sensor_deduped_viz (ReadTimeUnix INT, ReadTimeCST DATETIME, Location VARCHAR(255), Humidity FLOAT, TempCelsius FLOAT, TempFahrenheit FLOAT);
CREATE TABLE IF NOT EXISTS sensor_table_rows (CheckDateUnix INT, table_name VARCHAR(255), table_rows INT);

SET GLOBAL event_scheduler = ON;
USE lz;
CREATE EVENT IF NOT EXISTS prune_raw ON SCHEDULE EVERY 60 MINUTE STARTS CURRENT_TIMESTAMP DO DELETE FROM lz.sensor_raw WHERE ReadTime < unix_timestamp(now()) - 3600;
CREATE EVENT IF NOT EXISTS raw_to_deduped ON SCHEDULE EVERY 1 MINUTE STARTS CURRENT_TIMESTAMP DO INSERT INTO sensor_deduped_viz (ReadTimeUnix, ReadTimeCST, Location, Humidity, TempCelsius, TempFahrenheit) select distinct ReadTime as ReadTimeUnix,convert_tz(from_unixtime(ReadTime),'+00:00','-05:00') as ReadTimeCST,Location,Humidity,Temp as TempCelsius,(Temp * 9/5) + 32 as TempFahrenheit from sensor_raw where ReadTime > ifnull((select max(ReadTimeUnix) from sensor_deduped_viz),0);
CREATE EVENT IF NOT EXISTS table_rows_load ON SCHEDULE EVERY 1 MINUTE STARTS CURRENT_TIMESTAMP DO INSERT INTO sensor_table_rows (CheckDateUnix, table_name, table_rows) select unix_timestamp(now()) as CheckDateUnix, table_name, table_rows  from information_schema.tables where table_schema = 'lz' and table_name != "sensor_table_rows";
CREATE EVENT IF NOT EXISTS prune_table_rows ON SCHEDULE EVERY 60 MINUTE STARTS CURRENT_TIMESTAMP DO DELETE FROM sensor_table_rows WHERE CheckDateUnix < unix_timestamp(now()) - 9600;




quit
