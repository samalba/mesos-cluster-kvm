#!/bin/bash
# source: http://mesosphere.com/docs/getting-started/datacenter/install/

set -x

trap 'trap_errors' ERR

trap_errors() {
    echo "Error occured, abort." >&2
    exit 1
}

# Script arguments
node_id=$1
num_nodes=$2
private_network=$3
my_ip=${private_network}$(expr $node_id + 4)

# Zookeeper ID
echo $node_id > /etc/zookeeper/conf/myid

# Expose the private IP
echo $my_ip > /etc/mesos-master/hostname
echo $my_ip > /etc/mesos-master/ip
cp /etc/mesos-master/{hostname,ip} /etc/mesos-slave

# Zookeeper masters IPs
buf="zk://"
for (( i=1; i <= $num_nodes; i++ ))
do
    ip=${private_network}$(expr $i + 4)
    echo "server.${i}=${ip}:2888:3888" >>/etc/zookeeper/conf/zoo.cfg
    buf=${buf}${ip}:2181
    if [ $i -lt $num_nodes ]; then
        buf=${buf},
    fi
done
echo ${buf}/mesos >/etc/mesos/zk

# Quorum
echo $(expr $num_nodes / 2 + 1) >/etc/mesos-master/quorum

# Restart services
service zookeeper restart
service mesos-master restart
service mesos-slave restart
service marathon restart
