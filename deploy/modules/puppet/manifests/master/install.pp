class puppet::master::install {
	package{"puppet-server":
        ensure => latest,
        require => Class[repos]
    }
}
