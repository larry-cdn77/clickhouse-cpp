#!/bin/sh
# set load_balancing to look at primary replica regardless of user configuration
echo "SELECT COUNT(*) FROM clickhouse_cpp_dist;
  SELECT * FROM clickhouse_cpp_dist ORDER BY time LIMIT 5;
  SELECT * FROM clickhouse_cpp_dist ORDER BY time DESC LIMIT 5;" |
  ssh $1 clickhouse-client --load_balancing first_or_random -n || exit $?
sleep 5 # wait for query log, if needed
while [ $# -gt 0 ] ; do
  echo "SELECT COUNT(*) FROM clickhouse_cpp;
    SELECT * FROM clickhouse_cpp ORDER BY time LIMIT 5;
    SELECT * FROM clickhouse_cpp ORDER BY time DESC LIMIT 5;
    --SELECT event_time, exception_code, read_rows, substring(query, 1, 40)
    --FROM system.query_log WHERE query LIKE 'SELECT clickhouse_cpp.time%'
    --AND type = 'QueryFinish' FORMAT CSV;
    --SELECT event_time, exception_code, written_rows, substring(query, 1, 40)
    --FROM system.query_log WHERE query LIKE 'INSERT%'
    --AND type = 'QueryFinish' FORMAT CSV;" |
    ssh $1 clickhouse-client -n || exit $?
  shift
done
