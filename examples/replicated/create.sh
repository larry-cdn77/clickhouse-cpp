#!/bin/sh
r=1
while [ $# -gt 0 ] ; do
  echo "CREATE TABLE clickhouse_cpp ( time dateTime, id UInt32 ) ENGINE =
    ReplicatedMergeTree('/clickhouse/tables/default/clickhouse_cpp', '$r')
    ORDER BY time
    PARTITION BY toYYYYMM(time);
    ALTER TABLE system.query_log DELETE WHERE 1;" |
    ssh $1 clickhouse-client -n || exit $?
  let r++
  shift
done
