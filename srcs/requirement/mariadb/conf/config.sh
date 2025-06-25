#!/bin/bash

mysqld_safe &

until mysqladmin ping --silent; do
    echo 'En attente de mysqld'
    sleep 2
done

mysql -u root <<-EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOTPASS}';
  CREATE DATABASE IF NOT EXISTS \`${SQL_DB}\`;
  CREATE USER IF NOT EXISTS \`${SQL_USR}\`@'%' IDENTIFIED BY '${SQL_PASS}';
  GRANT ALL PRIVILEGES ON \`${SQL_DB}\`.* TO \`${SQL_USR}\`@'%';
  FLUSH PRIVILEGES;
EOSQL

mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

exec mysqld_safe