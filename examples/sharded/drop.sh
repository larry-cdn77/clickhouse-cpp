#!/bin/sh
echo "DROP TABLE clickhouse_cpp.D" | ssh $1 clickhouse-client --echo
while [ $# -gt 0 ] ; do
  echo "DROP TABLE clickhouse_cpp.T; DROP DATABASE clickhouse_cpp;" |
    ssh $1 clickhouse-client --echo -n --ignore-error
  shift
done
