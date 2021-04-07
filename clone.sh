#!/bin/sh
source ping.sh

echo "==> Dumping data from $mysql_url"
dumpFile="data.sql"
mysqldump -h $MYSQL_HOST --port $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASS $MYSQL_DATABASE --no-tablespaces > $dumpFile
if [[ $? != 0 ]]; then exit 1; fi
dumpFileSize=$(du -sh $dumpFile | cut -f1)
echo "==> Finish dumping data. Dump size $dumpFileSize"

echo "==> Importing data to $target_mysql_url"
mysql -h $TARGET_MYSQL_HOST --port $TARGET_MYSQL_PORT -u $TARGET_MYSQL_USER -p$TARGET_MYSQL_PASS $TARGET_MYSQL_DATABASE < data.sql
if [[ $? != 0 ]]; then exit 1; fi
echo "==> Finish import data"
