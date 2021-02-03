#!/bin/sh
echo "SELECT time, hex(id) FROM clickhouse_cpp.D ORDER BY time" |
  ssh $1 clickhouse-client --external --types=DateTime,UInt64 \
  --file=- \>/tmp/out.txt \; grep -e ..00000000 -e ..004C4B3F /tmp/out.txt
while [ $# -gt 0 ] ; do
  echo "SELECT COUNT(*) FROM clickhouse_cpp.T" | ssh $1 clickhouse-client
  shift
done
