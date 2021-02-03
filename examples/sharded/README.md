A sharded set of non-replicated MergeTree tables
================================================

Usage:

    make -C ../../build producer
    sh create.sh $host1 $host2 $host3
    time PATH=../../build/producer:$PATH sh run.sh $host1_ip 1 &
    time PATH=../../build/producer:$PATH sh run.sh $host2_ip 2 &
    time PATH=../../build/producer:$PATH sh run.sh $host3_ip 3 &
    sh stats.sh $host1 $host2 $host3
    sh drop.sh $host1 $host2 $host3

In the above, `$host1`, `$host2` and `$host3` are hosts participating cluster as
defined in `remote_server` section of config.xml under the name:

    clickhouse_cluster

The last argument to the run script is a marker to tell rows apart when read
back
