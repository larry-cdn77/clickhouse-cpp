#!/bin/sh
replica=1
while [ $# -gt 0 ] ; do
  echo "CREATE TABLE clickhouse_cpp ( time dateTime, id UInt64 ) ENGINE =
    ReplicatedMergeTree('/clickhouse/tables/default/clickhouse_cpp', '$replica')
    ORDER BY time PARTITION BY toYYYYMM(time);
    SHOW CREATE clickhouse_cpp FORMAT Vertical;
    ALTER TABLE system.query_log DELETE WHERE 1;" |
  ssh $1 clickhouse-client -n --echo
  let replica++
  shift
done
