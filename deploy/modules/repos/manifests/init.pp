class repos {
  yumrepo { 'local-vagrant':
    baseurl  => 'file:///vagrant/deploy/packages',
    descr    => 'Local packages',
    gpgcheck => 0
  } ->

  package{"epel-release":
    ensure => present,
  } ->

  package{"puppetlabs-release":
    ensure => present,
  }
}

