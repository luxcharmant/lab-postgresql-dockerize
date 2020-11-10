FROM postgres

COPY dumps/ /tmp/sql_dumps
COPY create-multiple-postgresql-databases.sh /docker-entrypoint-initdb.d/
