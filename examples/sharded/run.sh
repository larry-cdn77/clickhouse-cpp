#!/bin/sh
length=5000000
start=`expr $2 \* $length`
set -x
producer $1 clickhouse_cpp $start $length
