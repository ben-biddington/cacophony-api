#!/bin/bash
set -e
echo "Starting up container"
echo "Starting postgres"
echo "listen_addresses = '*'"                                                >> /etc/postgresql/9.5/main/postgresql.conf

#cat /etc/postgresql/9.5/main/postgresql.conf
#cat /etc/postgresql/9.5/main/pg_hba.conf

service postgresql restart
#sudo -i -u postgres
sudo -i -u postgres whoami

sudo -i -u postgres psql -c "CREATE USER test"

sudo -i -u postgres psql -c "CREATE DATABASE cacophonytest WITH OWNER test;"
#RUN \c [database]
#psql -c "CREATE EXTENSION postgis"

#echo "Database created"
#sudo -i -u root
echo whoami
node Server.js


