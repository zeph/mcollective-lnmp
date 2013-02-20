class roles::middleware {
  exec{"/usr/bin/curl http://srt.ly/mcvagrantcounter": }

  service{"iptables": ensure => stopped}

  class{"repos": } ->
  class{"redis": } ->
  class{"puppet": } ->
  class{"nagios": } ->
  class{"puppet::master": } ->
  class{"mcollective": } ->
  Class[$name]
}
