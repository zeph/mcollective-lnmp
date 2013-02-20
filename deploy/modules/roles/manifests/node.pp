class roles::node {
  class{"repos": } ->
  class{"puppet": } ->
  class{"nagios": } ->
  class{"mcollective": } ->
  Class[$name]
}
