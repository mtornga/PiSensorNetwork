docker network create web
docker run --name nifi --network web -p 8080:8080 -p 4201:4201 -dit apache/nifi
docker cp mysql-connector-java-8.0.17.jar nifi:./mysql-connector-java-8.0.17.jar
docker cp Get_reading_write_to_mysql.xml nifi:/Get_reading_write_to_mysql.xml
docker run --name finaldb --network web -p 3306:3306 -e MYSQL_ROOT_PASSWORD='bobs' -itd mysql
docker cp mysqlscript.sql finaldb:/root/mysqlscript.sql
#docker cp mysql_etl_raw_dedupe.sql finaldb:/root/mysql_etl_raw_dedupe.sql
sleep 30
docker exec finaldb bash -c 'mysql -uroot -pbobs < /root/mysqlscript.sql' 
docker run --name grafana --network web -p 3000:3000 -dit -e "GF_SECURITY_ADMIN_PASSWORD=secret" grafana/grafana

