#!/bin/sh
host1=$1
while [ $# -gt 0 ] ; do
  echo "CREATE DATABASE clickhouse_cpp;
    CREATE TABLE clickhouse_cpp.T ( time dateTime, id UInt64 )
    ENGINE = MergeTree()
    ORDER BY time PARTITION BY toYYYYMM(time); \
    SHOW CREATE clickhouse_cpp.T FORMAT Vertical;
    ALTER TABLE system.query_log DELETE WHERE 1;" |
    ssh $1 clickhouse-client --echo -n
  shift
done
echo "CREATE TABLE clickhouse_cpp.D AS clickhouse_cpp.T
  ENGINE = Distributed(clickhouse_cluster, clickhouse_cpp, T, rand());
  SHOW CREATE clickhouse_cpp.D FORMAT Vertical;" |
  ssh $host1 clickhouse-client -n --echo
