#!/bin/sh
length=5000000
start=`expr $3 \* $length`
set -x
producer $1 $2.clickhouse_cpp $start $length
