#!/bin/sh
h1=`echo $1 | cut -d: -f1`
db1=`echo $1 | cut -d: -f2 | cut -d, -f1`
while [ $# -gt 0 ] ; do
  h=`echo $1 | cut -d: -f1`
  r=1
  for d in `echo $1 | cut -d: -f2 | sed 's/,/ /g' ` ; do
    echo "CREATE TABLE $d.clickhouse_cpp ( time dateTime, id UInt32 ) ENGINE =
      ReplicatedMergeTree('/clickhouse/tables/$d/clickhouse_cpp', '$r')
      ORDER BY time
      PARTITION BY toYYYYMM(time)" |
      ssh $h clickhouse-client || exit $?
    let r++
  done
  echo "ALTER TABLE system.query_log DELETE WHERE 1" |
    ssh $h clickhouse-client || exit $?
  shift
done
echo "CREATE TABLE clickhouse_cpp_dist AS $db1.clickhouse_cpp
  ENGINE = Distributed(clickhouse_cluster, '', clickhouse_cpp)" |
  ssh $h1 clickhouse-client
