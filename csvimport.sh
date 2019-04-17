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
echo "Enter the Correct Directory Name";
fi

for TABLE in `cat ${Current_Dir}/${KEYSPACE_NAME}.TABLES`; do

cqlsh ${NODE_IP} -e "COPY ${KEYSPACE_NAME}.${TABLE} FROM '${BACKUP_DIR}/${TABLE}.csv' WITH HEADER = TRUE;"

echo Imported ${KEYSPACE_NAME}.${TABLE} from Location ${BACKUP_DIR}/${TABLE}.csv on `date` >> ${Current_Dir}/import.log;

done
