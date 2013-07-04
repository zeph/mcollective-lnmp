class rabbitmq::repo::rhel (
    $package_name = 'rabbitmq-server',
    $key = "http://www.rabbitmq.com/rabbitmq-signing-key-public.asc",
    $erepo = "http://repos.fedorapeople.org/repos/peter/erlang/epel-erlang.repo",
    $version = "2.8.4",
    $relversion = "1",
) { 
    exec { "rpm --import ${key}":
        path => ["/bin","/usr/bin","/sbin","/usr/sbin"],
    }

    package { $package_name:
        provider => rpm,
        ensure => installed,
	notify => Class['rabbitmq::service'],
        source => "http://www.rabbitmq.com/releases/rabbitmq-server/v${version}/rabbitmq-server-${version}-${relversion}.noarch.rpm",
        require => [Exec["rpm --import ${key}"], Package["erlang"]],
    }

    # wget -O /etc/yum.repos.d/epel-erlang.repo http://repos.fedorapeople.org/repos/peter/erlang/epel-erlang.repo && yum install erlang
    package { "erlang":
        ensure => installed,
        require => Exec["wget -O /etc/yum.repos.d/epel-erlang.repo ${erepo}"],
    }

    exec { "wget -O /etc/yum.repos.d/epel-erlang.repo ${erepo}":
        path => ["/bin","/usr/bin","/sbin","/usr/sbin"],
    }

}

