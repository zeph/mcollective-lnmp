# Class: rabbitmq::service
#
#   This class manages the rabbitmq server service itself.
#
#   Jeff McCune <jeff@puppetlabs.com>
#
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class rabbitmq::service(
  $service_name = 'rabbitmq-server',
  $ensure='running'
) {

  validate_re($ensure, '^(running|stopped)$')
  if $ensure == 'running' {
    Rabbitmq_plugin<| |>  ->
    # we need the plugins before the service starts
    Class['rabbitmq::service'] -> Rabbitmq_user<| |>
    Class['rabbitmq::service'] -> Rabbitmq_vhost<| |>
    Class['rabbitmq::service']
    -> Rabbitmq_user_permissions<| |>
    -> Exec['Download rabbitmqadmin']
    # and we can grab the cli from the webservice
    # only if it is up and configured... 
    -> Rabbitmq_exchange<| |>
    $ensure_real = 'running'
    $enable_real = true
  } else {
    $ensure_real = 'stopped'
    $enable_real = false
  }

  service { $service_name:
    ensure     => $ensure_real,
    enable     => $enable_real,
    hasstatus  => true,
    hasrestart => true,
  }

}
