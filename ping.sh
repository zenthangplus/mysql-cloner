#!/bin/sh

if [ -z $MYSQL_HOST ] || [ -z $MYSQL_USER ] || [ -z $MYSQL_PASS ] || [ -z $MYSQL_DATABASE ]; then
    echo "Missing MYSQL_HOST, MYSQL_USER, MYSQL_PASS or MYSQL_DATABASE"
    exit 1
fi

if [ -z $TARGET_MYSQL_HOST ] || [ -z $TARGET_MYSQL_USER ] || [ -z $TARGET_MYSQL_PASS ] || [ -z $TARGET_MYSQL_DATABASE ]; then
    echo "Missing TARGET_MYSQL_HOST, TARGET_MYSQL_USER, TARGET_MYSQL_PASS or TARGET_MYSQL_DATABASE"
    exit 1
fi

if [ -z $MYSQL_PORT ]; then
  MYSQL_PORT="3306"
fi

if [ -z $TARGET_MYSQL_PORT ]; then
  TARGET_MYSQL_PORT="3306"
fi

export mysql_url="$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DATABASE"
export target_mysql_url="$TARGET_MYSQL_HOST:$TARGET_MYSQL_PORT/$TARGET_MYSQL_DATABASE"

echo "==> Ping $mysql_url"
mysqladmin status -h $MYSQL_HOST --port $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASS --connect_timeout=3
if [ $? != 0 ]; then
  echo "==> ERROR: Cannot connect to $mysql_url"
  exit 1
fi

echo "==> Ping $target_mysql_url"
mysqladmin status -h $TARGET_MYSQL_HOST --port $TARGET_MYSQL_PORT -u $TARGET_MYSQL_USER -p$TARGET_MYSQL_PASS
if [ $? != 0 ]; then
  echo "==> ERROR: Cannot connect to $target_mysql_url"
  exit 1
fi
