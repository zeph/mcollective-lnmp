class motd {
  file{"/etc/motd":
    owner => root,
    group => root,
    mode  => 0644,
    source => "puppet:///modules/motd/motd"
  } ~>

  exec{"/usr/bin/curl http://srt.ly/mcvagrantcounter":
    refreshonly => true
  }
}
