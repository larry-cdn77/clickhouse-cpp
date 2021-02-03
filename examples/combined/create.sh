#!/bin/sh
host1=`echo $1 | cut -d: -f1`
database1=`echo $1 | cut -d: -f2 | cut -d, -f1`
while [ $# -gt 0 ] ; do
  h=`echo $1 | cut -d: -f1`
  replica=1
  for d in `echo $1 | cut -d: -f2 | sed 's/,/ /g' ` ; do
    echo "CREATE TABLE $d.clickhouse_cpp ( time dateTime, id UInt64 )
      ENGINE = ReplicatedMergeTree('/clickhouse/tables/$d/clickhouse_cpp', '$replica')
      ORDER BY time PARTITION BY toYYYYMM(time)" |
      ssh $h clickhouse-client --echo
    echo "SHOW CREATE $d.clickhouse_cpp FORMAT Vertical" |
      ssh $h clickhouse-client | grep /clickhouse
    let replica++
  done
  echo "ALTER TABLE system.query_log DELETE WHERE 1" |
    ssh $h clickhouse-client --echo
  shift
done
echo "CREATE TABLE clickhouse_cpp_dist AS $database1.clickhouse_cpp \
  ENGINE = Distributed(clickhouse_cluster, '', clickhouse_cpp, rand());
  SHOW CREATE clickhouse_cpp_dist FORMAT Vertical;" |
    ssh $host1 clickhouse-client -n --echo
