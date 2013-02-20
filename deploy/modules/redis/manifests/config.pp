class redis::config {
  file{"/etc/redis.conf":
    owner => root,
    group => root,
    mode => 644,
    source => "puppet:///modules/redis/redis.conf"
  }
}
