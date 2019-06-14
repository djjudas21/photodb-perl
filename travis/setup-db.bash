#!/bin/bash

mysql -e "create schema ${DBNAME}; GRANT ALL PRIVILEGES ON ${DBNAME}.* TO ${DBUSER}@${DBHOST} IDENTIFIED BY '${DBPASS}'"
mkdir -p ~/.photodb
echo -e "[database]\nuser=${DBUSER}\nschema=${DBNAME}\npass=${DBPASS}\nhost=${DBHOST}" > ~/.photodb/photodb.ini
