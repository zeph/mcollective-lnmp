class roles::middleware {
  service{"iptables": ensure => stopped}

  class{"repos": } ->
  class{"redis": } ->
  class{"puppet": } ->
  class{"puppet::master": } ->
  class{"mcollective": } ->
  Class[$name]
}
