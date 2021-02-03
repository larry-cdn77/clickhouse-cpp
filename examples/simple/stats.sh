#!/bin/sh
echo "SELECT COUNT(*) FROM clickhouse_cpp;
  SELECT * FROM clickhouse_cpp ORDER BY time LIMIT 5;
  SELECT * FROM clickhouse_cpp ORDER BY time DESC LIMIT 5;
  SELECT event_time, type, exception_code, written_rows, address,
  substring(query, 1, 50) FROM system.query_log WHERE query LIKE 'INSERT%'
  AND type = 'QueryFinish' FORMAT Vertical;" |
  ssh $1 clickhouse-client -n
