#!/bin/sh
echo "SELECT time, hex(id) FROM clickhouse_cpp_dist ORDER BY time" |
  ssh $1 clickhouse-client
while [ $# -gt 0 ] ; do
  echo "SELECT COUNT(*) FROM clickhouse_cpp" | ssh $1 clickhouse-client
  shift
done
