#!/bin/bash
set -e

echo "listen_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf

service postgresql restart

sudo -i -u postgres psql -c "CREATE USER test with password 'test'"
sudo -i -u postgres psql -c "CREATE USER admin_test with password 'admin_test'"
sudo -i -u postgres psql -c "CREATE DATABASE cacophony WITH OWNER test;"
sudo -i -u postgres psql cacophony -c "CREATE EXTENSION postgis"

echo "[hit enter key to exit] or run 'docker stop <container>'"

read
