class puppet::master::install {
  if $::osfamily == 'Debian' {
    $puppetmaster_packagename = 'puppetmaster'
  } else {
    $puppetmaster_packagename = 'puppet-server'
  }
  package{$puppetmaster_packagename:
    ensure => latest
  }
}
