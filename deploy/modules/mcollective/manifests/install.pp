class mcollective::install {
  if $::osfamily == 'Debian' {
    package {'ruby-stomp':
      ensure => latest,
      before => Package['mcollective'],
    }
    package{["rake", "ruby-rspec", "ruby-mocha"]:
      ensure => latest
    }
  } else {
    package{["rubygem-rake", "rubygem-rspec", "rubygem-mocha"]:
      ensure => latest
    }
  }

  package{["mcollective", "mcollective-client", "gnuplot"]:
    ensure => latest
  }

  # FIXME :: I shall actually read $target from mcollective::plugin_config
  file { "/etc/mcollective/plugin.d":
    ensure => 'directory',
    require => Package['mcollective'],
  }
}
