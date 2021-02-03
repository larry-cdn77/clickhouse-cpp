#!/bin/sh
set -x
producer $1 clickhouse_cpp $2 10
