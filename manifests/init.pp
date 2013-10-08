# == Class: awscli
#
# === Authors
#
# John Reeder <john.reeder@gettyimages.com>
# Justin Clayton <justin.clayton@gettyimages.com>
#
# === Copyright
#
# Copyright 2013 Getty Images, unless otherwise noted.
#
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