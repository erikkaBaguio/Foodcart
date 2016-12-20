# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box       = "spantree/Centos-6.5_x86-64"
  #config.vm.box_url   = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"

  config.vm.host_name = "AgriSenso"

  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 80, host: 8085
  config.vm.network "forwarded_port", guest: 5432, host: 5433

  #config.vm.provider "virtualbox" do |vb|
   #  vb.name = "AgriSenso"
  #end



  config.vm.provision :shell, :path => "provision/setup.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "standalone.pp"
  end



#  config.vm.provision :shell, :inline => "cd /vagrant && stdbuf -o0 fab build; exit 0"
end
