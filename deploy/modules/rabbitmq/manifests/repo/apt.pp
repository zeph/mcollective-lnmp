# sets up the vmware hosted apt repo
# requires
#   puppetlabs-apt
#   puppetlabs-stdlib
class rabbitmq::repo::apt(
  $package_name = 'rabbitmq-server',
  $pin = undef
) {


  package { $package_name: 
    ensure => installed, 
  }

  apt::source { 'rabbitmq':
    location    => 'http://www.rabbitmq.com/debian/',
    release     => 'testing',
    repos       => 'main',
    include_src => false,
    key         => '056E8E56',
    key_content => template('rabbitmq/rabbit.pub.key'),
    pin         => $pin,
  }

  if ! ($pin == undef) {
    validate_re($pin, '\d\d\d')
    apt::pin { 'rabbitmq':
      packages => 'rabbitmq-server',
      priority => $pin,
    }
  }
}
