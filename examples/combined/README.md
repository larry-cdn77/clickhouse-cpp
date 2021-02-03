A sharded set of replicated MergeTree tables
============================================

The example is intended to work with multiple shard databases per host (node),
what is sometimes described as cross-segmented topology. Use case is a host
that has one shard's primary replica and other shard's secondary replicas.
With the same table name used throughout, the replicas reside in different name
databases on each host. Distributed table then specifies an empty database name
and ClickHouse supplies a name based on choice of replica.

Usage:

    make -C ../../build producer
    sh create.sh SPEC
    time PATH=../../build/producer:$PATH sh run.sh $host1_ip 1 &
    time PATH=../../build/producer:$PATH sh run.sh $host2_ip 2 &
    time PATH=../../build/producer:$PATH sh run.sh $host3_ip 3 &
    wait
    sh stats.sh SPEC
    sh drop.sh SPEC

The last argument to the run script is a marker to tell rows apart when read
back

SPEC is of the form:

    $host1:db1,db2 $host2:db2,db3 $host3:db3,db1

Where `$host1`, `$host2` and `$host3` are hosts participating cluster as defined
in `remote_server` section of config.xml under the name:

    clickhouse_cluster

Replicas of data for shard 1, 2 and 3 is under database `db1`, `db2` and `db3`,
respectively. The first database listed in SPEC for each host corresponds to the
primary replica 1, followed by databases for one or more secondary replicas.

Replicas are defined in ZooKeeper with path prefix:

    /clickhouse/tables/
