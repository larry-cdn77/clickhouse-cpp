#!/bin/sh
set -x
producer $1 $2.clickhouse_cpp $3 5000000
