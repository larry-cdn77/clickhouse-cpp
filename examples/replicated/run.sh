#!/bin/sh
set -x
producer $1 clickhouse_cpp 0 5000000
