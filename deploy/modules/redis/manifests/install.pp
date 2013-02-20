class redis::install {
  package{"redis":
    ensure => latest,
    require => Class["repos"]
  }
}
