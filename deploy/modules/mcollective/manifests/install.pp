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
}
