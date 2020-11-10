#!/bin/bash

set -e
set -u

function create_user_and_database() {
	local database=$1
	echo "  Creating user and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE USER $database;
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
        GRANT ALL PRIVILEGES ON DATABASE $database TO $POSTGRES_USER;
EOSQL
}

function import_data_from_database() {
    local database=$1
    echo "  Importing data into database '$database'"
    psql -v ON_ERROR_STOP=1 --username "$database" < /tmp/sql_dumps/"$database".sql
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	echo "Multiple databases creation requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
	done
	echo "Multiple databases created"

    echo "Multiple databases data fill requested: $POSTGRES_MULTIPLE_DATABASES"
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		import_data_from_database $db
	done
	echo "Multiple databases data filled"
fi