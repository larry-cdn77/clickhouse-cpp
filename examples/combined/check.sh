#!/bin/sh
h1=`echo $1 | cut -d: -f1`
for i in 1 2 3 ; do # go multiple times to exercise replica selection
  echo "SELECT COUNT(*) FROM clickhouse_cpp_dist;
    SELECT * FROM clickhouse_cpp_dist ORDER BY time LIMIT 5;
    SELECT * FROM clickhouse_cpp_dist ORDER BY time DESC LIMIT 5;" |
    ssh $h1 clickhouse-client -n || exit $?
done
