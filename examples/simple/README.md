One non-replicated MergeTree table
==================================

Usage:

    make -C ../../build producer
    sh create.sh $host
    time PATH=../../build/producer:$PATH sh run.sh $host_ip
    sh stats.sh $host
    sh drop.sh $host
