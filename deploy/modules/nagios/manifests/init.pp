class nagios {
    class{"nrpe": require => Class["repos"]}

    package{["nagios-plugins-load", "nagios-plugins-disk", "nagios-plugins-swap"]:
        ensure => present,
        require => Class["repos"]
    }

    nrpe::command {'check_swap':
        ensure => present,
        command => "check_swap -w 30% -c 20%"
    }

    nrpe::command {'check_disks':
        ensure => present,
        command => "check_disk -l -w 15% -c 10% -e"
    }

    nrpe::command {'check_load':
        ensure => present,
        command => "check_load -w 1.5,1.5,1.5 -c 2,2,2"
    }

    file{"/etc/mcollective/plugin.d/nrpe.cfg":
        content => "conf_dir=/etc/nrpe.d",
        require => Class["mcollective::install"],
        notify => Class["mcollective::service"]
    }
}
