One non-replicated MergeTree table
==================================

Usage:

    make -C ../../build producer
    sh create.sh $host
    PATH=../../build/producer:$PATH sh run.sh $host_ip
    sh check.sh $host
    sh drop.sh $host
