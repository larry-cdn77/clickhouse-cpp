#!/bin/sh
echo "DROP TABLE clickhouse_cpp" | ssh $1 clickhouse-client
