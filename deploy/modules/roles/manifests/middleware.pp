class roles::middleware {
  if $::osfamily != 'Debian' {
    service{"iptables": ensure => stopped}
  }

  class{"puppet": } ->
  class{"puppet::master": } ->
  class{"mcollective": } ->
  Class[$name]

  class{'rabbitmq':
    version      => "3.1.2",
    config_stomp => true,
  } 

  $plugins  = ['rabbitmq_stomp']

  rabbitmq_plugin { $plugins:
    ensure => present,
    provider => 'rabbitmqplugins',
  } 
  rabbitmq_user { 'mcollective':
    admin    => true,
    password => 'changeme',
    provider => 'rabbitmqctl',
  } 
  rabbitmq_vhost { '/mcollective':
    ensure => present,
    provider => 'rabbitmqctl',
  } 
  rabbitmq_user_permissions { 'mcollective@/mcollective':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
    provider => 'rabbitmqctl',
  } 
  rabbitmq_exchange { 'mcollective_broadcast@/mcollective':
    type     => 'topic',
    provider => 'rabbitmqadmin',
    user     => 'mcollective',
    password => 'changeme',
  }  
  rabbitmq_exchange { 'mcollective_directed@/mcollective':
    type => 'direct',
    provider => 'rabbitmqadmin',
    user => 'mcollective',
    password => 'changeme',
  }

  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
  }

  $packages_php = [
    'cgi', 'curl', 'gd', 'imagick', 'mcrypt',
    'memcache', 'memcached', 'mysql', 'pspell', 'recode',
    # (v5.3.14 specific) 'snmp',
    'sqlite', 'tidy', 'xmlrpc', 'ldap', 'xsl',
    # (inherited) 'cli', 'common', 'fpm',
  ]

  include php::cli
  php::module {$packages_php: }

  class { 'nginx': }

  nginx::resource::location { "vagrant_local":
    location => '~ \.php$',
    vhost => "vagrant.local",
    fastcgi => '127.0.0.1:9001',
  }

  nginx::resource::vhost { 'vagrant.local':
    ensure => present,
    www_root => '/vagrant/www/shop/bob/public',
  }

  include php::fpm::daemon
  php::fpm::conf { 'www':
    listen  => '127.0.0.1:9001',
    user    => 'vagrant',
    group   => 'vagrant',
    # For the user to exist
    require => Package['nginx'],
  }

  package { 'mysql-server': ensure => installed }

}
