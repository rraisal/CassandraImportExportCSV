#!/bin/bash

Current_Dir=$PWD
KEYSPACE_NAME=
NODE_IP=
BACKUP_DIR=/var/lib/cassandra/CSV_Backups/${KEYSPACE_NAME}

echo "List all the table names to ' ${KEYSPACE_NAME}.TABLES ' Location : ${Current_Dir}"
echo Current_Dir: ${Current_Dir};
echo KEYSPACE_NAME: ${KEYSPACE_NAME};
echo NODE_IP: ${NODE_IP};
echo BACKUP_DIR: ${BACKUP_DIR};

if [ ! -d "$BACKUP_DIR" ]; then

mkdir -p $BACKUP_DIR
echo "Backup Directory Created";
fi

for TABLE in `cat ${Current_Dir}/${KEYSPACE_NAME}.TABLES`; do

cqlsh ${NODE_IP} -e "COPY ${KEYSPACE_NAME}.${TABLE} TO '${BACKUP_DIR}/${TABLE}.csv' WITH HEADER = TRUE;"

echo Exported ${KEYSPACE_NAME}.${TABLE} to Location ${BACKUP_DIR} with Name ${TABLE}.csv on `date` >> ${Current_Dir}/export.log;

done
