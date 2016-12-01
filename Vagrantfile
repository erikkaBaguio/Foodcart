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
    config.vm.network :forwarded_port, guest: 5000, host: 8080

    # Host-only access private network
    config.vm.network :private_network, ip: "192.168.33.10"



end
