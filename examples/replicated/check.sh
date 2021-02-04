#!/bin/sh
#echo "SELECT event_time, exception_code, written_rows, substring(query, 1, 40)
#  FROM system.query_log WHERE query LIKE 'INSERT%'
#  AND type = 'QueryFinish' FORMAT CSV" |
#  ssh $1 clickhouse-client || exit $?
while [ $# -gt 0 ] ; do
  echo "SELECT COUNT(*) FROM clickhouse_cpp;
    SELECT * FROM clickhouse_cpp ORDER BY time LIMIT 3;
    SELECT * FROM clickhouse_cpp ORDER BY time DESC LIMIT 3;" |
    ssh $1 clickhouse-client -n || exit $?
  shift
done
