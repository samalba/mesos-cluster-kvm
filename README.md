# mesos-cluster-kvm
Setup a multi-master Mesos cluster using Vagrant and KVM

## How to

### Install vagrant with kvm support

1. [Install Vagrant](https://www.vagrantup.com/downloads.html)
2. [Install Vagrant Libvirt plugin](https://github.com/pradels/vagrant-libvirt)
3. Make sure libvirt and qemu kvm are correctly installed
4. Make sure your user is part of the libvirtd group (test by running `virsh list')

### Create the cluster

$ git clone git@github.com:samalba/mesos-cluster-kvm.git
$ cd mesos-cluster-kvm
$ vagrant up

By default, 3 nodes are created but you can add or remove nodes by editing the `Vagrantfile'.
The configuration script will adjust the IPs config and quorum value accordingly.

### Test the cluster

$ vagrant ssh node-1 -c /vagrant/scripts/test_cluster.sh
