#!/bin/sh
set -x
producer $1 $2.insert_test $3 5000000
