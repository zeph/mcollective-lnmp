class roles::node {
  class{"repos": } ->
  class{"puppet": } ->
  class{"mcollective": } ->
  Class[$name]
}
