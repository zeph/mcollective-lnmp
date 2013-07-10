class roles::middleware {
  if $::osfamily != 'Debian' {
    service{"iptables": ensure => stopped}
  }

  class{"puppet": } ->
  class{"puppet::master": } ->
  class{"mcollective": } ->
  Class[$name]

  class{'rabbitmq::server':
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

  include php::cli
  php::module {[
    'curl',
    'dbg',
    'gd',
    'gmp',
    'ldap',
    'mysql',
    'odbc',
    'pgsql',
    'pspell',
    'recode',
    'snmp',
    'sqlite',
    'tidy',
    'xmlrpc',
    'xsl',
    'adodb',
    'auth-pam',
    'enchant',
    'exactimage',
    'ffmpeg',
    'geoip',
    'imagick',
    'imap',
    'interbase',
    'intl',
    'lasso',
    'librdf',
    'mapscript',
    'mcrypt',
    'memcache',
    'memcached',
    'midgard2',
    'ming',
    'mysqlnd',
    'ps',
    'radius',
    'remctl',
    'rrd',
    'sasl',
    'suhosin',
    'svn',
    'sybase',
    'tokyo-tyrant',
    'uuid',
    'xcache',
    'xdebug',]:
  }
}
