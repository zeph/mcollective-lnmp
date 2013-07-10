class rabbitmq::repo::rhel (
  $package_name = 'rabbitmq-server',
  $key = "http://www.rabbitmq.com/rabbitmq-signing-key-public.asc",
  $version = "2.8.4",
  $relversion = "1",
) { 
  exec { "rpm --import ${key}":
    path    => ["/bin","/usr/bin","/sbin","/usr/sbin"],
    onlyif  => 'test `rpm -qa | grep gpg-pubkey-056e8e56-468e43f2 | wc -l` -eq 0';
  }

  package { $package_name:
    provider => rpm,
    ensure => installed,
    notify => Class['rabbitmq::service'],
    source => "http://www.rabbitmq.com/releases/rabbitmq-server/v${version}/rabbitmq-server-${version}-${relversion}.noarch.rpm",
    require => [Exec["rpm --import ${key}"], Package["erlang"]],
  }

  # FIXME for Erlang we need EPEL repositories
  # http://www.rackspace.com/knowledge_center/article/installing-rhel-epel-repo-on-centos-5x-or-6x
  package { "erlang":
    ensure => latest,
  }
}

