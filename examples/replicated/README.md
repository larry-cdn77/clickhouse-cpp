One replicated MergeTree table
==============================

Usage:

    make -C ../../build producer
    sh create.sh $host1 $host2 $host3
    time PATH=../../build/producer:$PATH sh run.sh $host1_ip
    sh stats.sh $host1 $host2 $host3
    sh drop.sh $host1 $host2 $host3

In the above, `$host1`, `$host2` and `$host3` will be designated as test table
replica 1, 2 and 3, respectively using ZooKeeper path prefix:

    /clickhouse/tables/
