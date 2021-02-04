#!/bin/sh
h1=$1
while [ $# -gt 0 ] ; do
  echo "CREATE TABLE clickhouse_cpp ( time dateTime, id UInt32 )
    ENGINE = MergeTree()
    ORDER BY time
    PARTITION BY toYYYYMM(time);
    ALTER TABLE system.query_log DELETE WHERE 1;" |
    ssh $1 clickhouse-client -n || exit $?
  shift
done
echo "CREATE TABLE clickhouse_cpp_dist AS clickhouse_cpp
  ENGINE = Distributed(clickhouse_cluster, default, clickhouse_cpp)" |
  ssh $h1 clickhouse-client
