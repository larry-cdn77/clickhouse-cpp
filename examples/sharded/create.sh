#!/bin/sh
host1=$1
while [ $# -gt 0 ] ; do
  echo "CREATE TABLE clickhouse_cpp ( time dateTime, id UInt64 )
    ENGINE = MergeTree()
    ORDER BY time PARTITION BY toYYYYMM(time); \
    SHOW CREATE clickhouse_cpp FORMAT Vertical;
    ALTER TABLE system.query_log DELETE WHERE 1;" |
    ssh $1 clickhouse-client --echo -n
  shift
done
echo "CREATE TABLE clickhouse_cpp_dist AS clickhouse_cpp
  ENGINE = Distributed(clickhouse_cluster, default, clickhouse_cpp, rand());
  SHOW CREATE clickhouse_cpp_dist FORMAT Vertical;" |
  ssh $host1 clickhouse-client -n --echo
