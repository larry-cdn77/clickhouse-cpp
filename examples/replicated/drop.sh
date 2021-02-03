#!/bin/sh
while [ $# -gt 0 ] ; do
  echo "DROP TABLE clickhouse_cpp" | ssh $1 clickhouse-client --echo
  shift
done
