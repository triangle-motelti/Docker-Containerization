#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

cat << EOF > /etc/mysql/database_init.sql
CREATE DATABASE IF NOT EXISTS \`${db_name}\`;
CREATE USER IF NOT EXISTS \`${db_user}\`@'%' IDENTIFIED BY '${db_user_pass}';
GRANT ALL PRIVILEGES ON \`${db_name}\`.* TO \`${db_user}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${db_root_pass}';
FLUSH PRIVILEGES;
EOF

exec mysqld --user=mysql
