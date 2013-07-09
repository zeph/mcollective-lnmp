class mcollective::install {
  if $::osfamily == 'Debian' {
    package {'ruby-stomp':
      ensure => latest,
      before => Package['mcollective'],
    }
  }
  package{["mcollective", "gnuplot","rake", "ruby-rspec", "ruby-mocha"]:
      ensure => latest
  }

  # FIXME :: I shall actually read $target from mcollective::plugin_config
  file { "/etc/mcollective/plugin.d":
    ensure => 'directory',
    require => Package['mcollective'],
  }
}
