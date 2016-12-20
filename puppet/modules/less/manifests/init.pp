class less {
  package {'less':
    ensure   => present,
    provider => 'npm',
    require => Class['nodejs']
  }
}