#
# Standalone manifest - for dev Vagrant box.
#

import 'lib/*.pp'

include fabric
include gunicorn
include nginx
include postgresql
include python
include uglifyjs
include vagrant

class { 'nodejs':
  version      => 'stable',
}
package { 'less':
  provider => 'npm',
  require  => Class['nodejs']
}
package { 'bower':
  provider => 'npm',
  require  => Class['nodejs']
}
package { 'grunt':
  provider => 'npm',
  require  => Class['nodejs']
}

package { 'grunt-cli':
  provider => 'npm',
  require  => Class['nodejs']
}

nginx::site { 'gunicorn':
  config => 'gunicorn',
}
