class roles::middleware {
  service{"iptables": ensure => stopped}

  class{"repos": } ->

  class{ 'rabbitmq::server':
    version      => "3.1.2-1",
    plugins      => ['rabbitmq_stomp', 'rabbitmq_management'],
    config_stomp => true,
  } -> 

  class{"puppet": } ->
  class{"nagios": } ->
  class{"puppet::master": } ->
  class{"mcollective": } ->
  class{"motd": } ->
  Class[$name]

  rabbitmq_vhost { '/mcollective':
    ensure => present,
    provider => 'rabbitmqctl',
  }
  rabbitmq_user { 'mcollective':
    admin    => true,
    password => 'changeme',
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
    require  => Rabbitmq_user['mcollective'],
  } 
  rabbitmq_exchange { 'mcollective_directed@/mcollective':
    type => 'direct',
    provider => 'rabbitmqadmin',
    user => 'mcollective',
    password => 'changeme',
    require  => Rabbitmq_user['mcollective'],
  } 
}
