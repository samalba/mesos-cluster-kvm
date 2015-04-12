#!/bin/bash

set -x

trap 'trap_errors' ERR

trap_errors() {
    echo "Error occured, abort." >&2
    exit 1
}

MASTER=$(mesos-resolve `cat /etc/mesos/zk`)
mesos-execute --master=$MASTER --name="cluster-test" --command="sleep 5"
echo ok
