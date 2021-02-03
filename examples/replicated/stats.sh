#!/bin/sh
echo "SELECT event_time, type, exception_code, written_rows, address,
  substring(query, 1, 50) FROM system.query_log WHERE query LIKE 'INSERT%'
  AND type = 'QueryFinish' FORMAT Vertical" |
  ssh $1 clickhouse-client
while [ $# -gt 0 ] ; do
  echo "SELECT COUNT(*) FROM clickhouse_cpp;
    SELECT * FROM clickhouse_cpp ORDER BY time LIMIT 3;
    SELECT * FROM clickhouse_cpp ORDER BY time DESC LIMIT 3;" |
  ssh $1 clickhouse-client -n
  shift
done
