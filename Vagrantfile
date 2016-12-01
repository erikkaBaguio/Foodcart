# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    # Box name
    config.vm.box = "nrel/CentOS-6.5-x86_64"

    # Hostname
    config.vm.host_name = "foodcart"

    # Provider box url
    # config.vm.box.url = 

    # Port forwarding
    config.vm.network :forwarded_port, guest: 80, host: 8085
    config.vm.network :forwarded_port, guest: 5000, host: 8081
    config.vm.network :forwarded_port, guest: 5432, host: 5433

    # Host-only access private network
    config.vm.network :private_network, ip: "192.168.33.10"

    # Shared folders
    config.vm.synced_folder "src/", "/var/www/src"

    # Puppet config
    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.manifest_file  = "init.pp"
        puppet.module_path = "puppet/modules"
    end

end
