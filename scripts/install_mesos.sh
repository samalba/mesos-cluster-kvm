#!/bin/bash

set -x

trap 'trap_errors' ERR

trap_errors() {
    echo "Error occured, abort." >&2
    exit 1
}

apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | \
      sudo tee /etc/apt/sources.list.d/mesosphere.list

apt-get -y update
apt-get -y install mesos marathon

# Docker support
echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo '5mins' > /etc/mesos-slave/executor_registration_timeout
