#!/bin/sh
echo "CREATE TABLE clickhouse_cpp ( time dateTime, id UInt32 )
  ENGINE = MergeTree()
  ORDER BY time
  PARTITION BY toYYYYMM(time);
  ALTER TABLE system.query_log DELETE WHERE 1;" |
  ssh $1 clickhouse-client -n
