define source_install($prefix, $tarball, $tmpdir, $flags) {
  exec { "retrieve-$name":
    command => "wget $tarball",
    cwd => "$tmpdir",
    before => Exec["extract-$name"],
    notify => Exec["extract-$name"],
  }

  exec { "extract-$name":
    command => "tar -zxf $name.tgz",
    cwd => $tmpdir,
    creates => "$tmpdir/$name/README",
    require => Exec["retrieve-$name"],
    before => Exec["configure-$name"],
  }

  exec { "configure-$name":
    cwd => "$tmpdir/$name",
    command => "./configure $flags --prefix=$prefix",
    require => Exec["extract-$name"],
    before => Exec["make-$name"],
  }

  exec { "make-$name":
    cwd => "$tmpdir/$name",
    command => "make && make install",
    require => Exec["configure-$name"],
  }
}

class python {
  define install ($prefix = "/usr/local",$tmpdir = "/tmp",$pipversion = "0.6.3",$version = "2.7") {
    Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }
    file { ["$prefix", "$tmpdir"]: ensure => directory }

    exec { "retrieve-distribute":
      command => "wget http://python-distribute.org/distribute_setup.py",
      cwd => $tmpdir,
      require => File["$prefix"],
    }

    exec { "retrieve-pip":
      command => "wget http://pypi.python.org/packages/source/p/pip/pip-$pipversion.tar.gz",
      cwd => $tmpdir,
      require => File["$prefix"],
      notify => Exec["extract-pip"],
    }

    exec { "extract-pip":
      command => "tar -zxf pip-$pipversion.tar.gz",
      cwd => $tmpdir,
      creates => "$tmpdir/pip-$pipversion",
      require => Exec["retrieve-pip"],
      subscribe => Exec["retrieve-pip"],
    }

    source_install { "Python-$version":
      prefix => $prefix,
      tarball => "http://python.org/ftp/python/$version/Python-$version.tgz",
      tmpdir => $tmpdir,
      flags => "",
    }

    exec { "install-distribute-$version":
      command =>"$prefix/bin/python distribute_setup.py",
      cwd => $tmpdir,
      require => [
                  Exec["retrieve-distribute"],
                  Source_install["Python-$version"]
                  ],
      before => Exec["install-pip-$version"],
    }

    exec { "install-pip-$version":
      command => "$prefix/bin/python setup.py install",
      cwd => "$tmpdir/pip-$pipversion",
      creates => "$prefix/bin/pip",
      subscribe => Exec["extract-pip"],
      require => [
                  Exec["extract-pip"],
                  Source_install["Python-$version"],
                  Exec["install-distribute-$version"]
                  ],
    }
  }

  define pip($version = undef, $ensure) {
    case $ensure {
      present: {
        exec { "pip-install-$name-$version":
	      command => "$prefix/bin/pip install $name",
	      timeout => "-1",
        }
      }
    }
  }
}

#variables
$postgres_password = 'temporary'

# Edit local /etc/hosts files to resolve some hostnames used on your application.
host { 'localhost.localdomain':
    ensure => 'present',
    target => '/etc/hosts',
    ip => '127.0.0.1',
    host_aliases => ['localhost', 'vagrant-test.my']
}




# Adding EPEL repo. We'll use later to install Redis class.
# class { 'epel': }


# Miscellaneous packages.
package { ['vim-enhanced','nc','zip','unzip','git', 'mlocate']: ensure => latest }

service { 'iptables':
  ensure => 'stopped',
  enable => 'false',
}

# Install PostgreSQL 9.4 server from the PGDG repository
 class {'postgresql::globals':
  encoding => 'UTF8',
  locale  => 'it_IT.utf8',
  manage_package_repo => true,
  version => '9.4',
}->


class { 'postgresql::server':
  listen_addresses => '*',
  ip_mask_allow_all_users    => '0.0.0.0/0',
  postgres_password => 'temporary',
}

# Install contrib modules
class { 'postgresql::server::contrib':}

class { 'postgresql::lib::devel':}

class { 'postgresql::server::plpython':}

postgresql::server::role{'ppg':
  password_hash => 'foodcart',
  username => 'ppg',
  createdb => true,
  superuser => true,
}

postgresql::server::database { 'foodcart':
  dbname => 'foodcart',
  template => 'template1',
}

class { 'apache': }

include ::scl::collections::python27
