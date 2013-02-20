class mcollective::install {
  package{["mcollective", "mcollective-client", "mcollective-common",
           "mcollective-package-agent", "mcollective-package-client",
           "mcollective-puppet-agent", "mcollective-puppet-client",
           "mcollective-service-agent", "mcollective-service-client",
           "mcollective-filemgr-agent", "mcollective-filemgr-client",
           "mcollective-nrpe-agent", "mcollective-nrpe-client",
           "mcollective-process-agent", "mcollective-process-client",
           "mcollective-nettest-agent", "mcollective-nettest-client",
           "gnuplot", "rubygem-redis"]:
               ensure => latest
  }
}
