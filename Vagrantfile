# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "spantree/Centos-6.5_x86-64"

  # Hostname
  config.vm.host_name = "foodcart"

  # Provider box url
  # config.vm.box.url = 

  # Port forwarding
  config.vm.network :forwarded_port, guest: 80, host: 8085
  config.vm.network :forwarded_port, guest: 5000, host: 5000
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
