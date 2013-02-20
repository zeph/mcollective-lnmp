class redis {
  class{"redis::install": } ->
  class{"redis::config": } ~>
  class{"redis::service": } ->
  Class[$name]
}
