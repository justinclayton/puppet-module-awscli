# Class: awscli
class awscli( $enable_epel = true ) {

  case $::osfamily {
    'redhat': {
      if $enable_epel {
        include epel
        Class['epel'] -> Package['python-pip']
      }
    }

    'debian': {
      # nothing special here yet
    }

    default: {
      fail("unsupported osfamily \"${::osfamily}\"")
    }
  }

  package { 'python-pip':
    ensure => installed,
  }

  package { 'awscli':
    ensure   => installed,
    provider => 'pip',
  }
}
