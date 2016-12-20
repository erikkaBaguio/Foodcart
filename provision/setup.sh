sudo yum -y install python-pip
sudo pip install flask
sudo pip install sqlalchemy
sudo pip install lettuce
yum -y install httpd
yum -y install postgresql

yum -y install lettuce
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

if which puppet > /dev/null ; then
        echo "Puppet is already installed"
        exit 0
fi

#-----------Puppet Configuration--------------------

# Enable Dependencies and Puppet Labs Repository On Master
sudo yum -y install ntp
rpm -ivh http://yum.puppetlabs.com/el/6.4/products/x86_64/puppetlabs-release-6-7.noarch.rpm

#install puppet on the master server
yum install -y puppet-server

#Start puppet-server
 #/etc/init.d/puppetmaster start

#install puppet on agent node
#sudo yum install puppet
echo "Puppet installed!"