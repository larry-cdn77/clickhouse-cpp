#!/bin/sh
echo "DROP TABLE insert_test_dist" |
  ssh `echo $1 | cut -d: -f1` clickhouse-client --echo
while [ $# -gt 0 ] ; do
  for d in `echo $1 | cut -d: -f2 | sed 's/,/ /g' ` ; do
    echo "DROP TABLE $d.insert_test" |
      ssh `echo $1 | cut -d: -f1` clickhouse-client --echo
  done
  shift
done
