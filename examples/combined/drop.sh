#!/bin/sh
echo "DROP TABLE clickhouse_cpp_dist" |
  ssh `echo $1 | cut -d: -f1` clickhouse-client --echo
while [ $# -gt 0 ] ; do
  for d in `echo $1 | cut -d: -f2 | sed 's/,/ /g' ` ; do
    echo "DROP TABLE $d.clickhouse_cpp" |
      ssh `echo $1 | cut -d: -f1` clickhouse-client --echo
  done
  shift
done
