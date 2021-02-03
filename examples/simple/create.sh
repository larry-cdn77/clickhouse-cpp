#!/bin/sh
echo "CREATE TABLE clickhouse_cpp ( time dateTime, id UInt64 )
  ENGINE = MergeTree()
  ORDER BY time PARTITION BY toYYYYMM(time);
  SHOW CREATE clickhouse_cpp FORMAT Vertical;
  ALTER TABLE system.query_log DELETE WHERE 1;" |
  ssh $1 clickhouse-client -n --echo
