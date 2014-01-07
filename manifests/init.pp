# Class: awscli
class awscli( $enable_epel = true ) {

  if $::osfamily != 'redhat' {
    fail("unsupported osfamily \"${::osfamily}\"")
  }

  if $enable_epel {
    include epel
    Class['epel'] -> Package['python-pip']
  }

  package { 'python-pip':
    ensure => installed,
  }

  package { 'awscli':
    ensure   => installed,
    provider => 'pip',
  }
}
