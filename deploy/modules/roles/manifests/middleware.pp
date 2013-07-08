class roles::middleware {
  service{"iptables": ensure => stopped}

  class{"repos": } ->
  class{"puppet": } ->
  class{"nagios": } ->
  class{"puppet::master": } ->
  class{"mcollective": } ->
  class{"motd": } ->
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

  ### Install php 5.4 ppa.
  class { 'nginxphp::ppa': }
  
  ### Initiate the module base requirements.
  include nginxphp
  
  ### Install php-fpm with the modules you desire.
  class { 'nginxphp::php':
    php_packages => [
      "php5-intl",
      "php5-curl",
      "php5-gd",
      "php5-xcache",
      "php5-mcrypt",
      "php5-xmlrpc",
      "php5-xsl"
    ],
    withppa      => true
  }
  
  ### Install Nginx
  include nginxphp::nginx
  
  ### Install PHP developement tools.
  include nginxphp::phpdev
  
  ### Configure FPM Pool
  nginxphp::fpmconfig { 'bob':
    php_devmode   => true,
    fpm_user      => 'www-data',
    fpm_group     => 'www-data',
    fpm_allowed_clients => ''
  }
  
  ### Configure Nginx site
  nginxphp::nginx_addphpconfig { 'cmantix.dev.local':
    website_root       => "/var/www/",
    default_controller => "index.php",
    require => Nginxphp::Fpmconfig['bob']
  }
}
