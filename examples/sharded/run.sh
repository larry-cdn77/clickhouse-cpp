#!/bin/sh
set -x
producer $1 clickhouse_cpp.T $2 5000000
