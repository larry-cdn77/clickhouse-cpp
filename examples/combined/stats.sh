#!/bin/sh
h=`echo $1 | cut -d: -f1`
echo "SELECT time, hex(id) FROM clickhouse_cpp_dist ORDER BY time" |
  ssh $h clickhouse-client --external --types=DateTime,UInt64 \
  --file=- \>/tmp/out.txt \; grep -e ..00000000 -e ..004C4B3F /tmp/out.txt
while [ $# -gt 0 ] ; do
  h=`echo $1 | cut -d: -f1`
  d=`echo $1 | cut -d: -f2 | cut -d, -f1`
  echo "SELECT COUNT(*) FROM $d.clickhouse_cpp" | ssh $h clickhouse-client
  shift
done
