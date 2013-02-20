class redis::service {
  service{"redis":
    ensure => running,
    enable => true
  }
}
