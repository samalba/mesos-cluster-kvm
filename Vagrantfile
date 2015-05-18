num_nodes = 3
private_network = '10.42.42.'

Vagrant.configure("2") do |config|
    num_nodes.times do |n|
        config.vm.define "node-#{n+1}" do |node|
            node.vm.box = "baremettle/ubuntu-14.04"
            node.vm.hostname = "node-#{n+1}"
            node.vm.provider :libvirt do |libvirt|
                libvirt.driver = "kvm"
            end
            node.vm.provider :libvirt do |domain|
                domain.memory = 1024
                domain.cpus = 2
                domain.nested = true
                domain.volume_cache = 'none'
            end
            node.vm.network :private_network, :ip => "#{private_network}#{n+5}"
            node.vm.network :public_network, :dev => "eth0", :mode => 'bridge'
            # node.vm.provision :hosts
            node.vm.provision "shell", path: "scripts/install_docker.sh"
            node.vm.provision "shell", path: "scripts/install_mesos.sh"
            node.vm.provision "shell", path: "scripts/configure_mesos_ha.sh", :args => "#{n+1} #{num_nodes} #{private_network}"
        end
    end
end
