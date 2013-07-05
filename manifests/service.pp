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
    Class['rabbitmq::service'] -> Rabbitmq_user<| |>
    -> Exec['Download rabbitmqadmin']
    Class['rabbitmq::service'] -> Rabbitmq_vhost<| |>
    Class['rabbitmq::service'] -> Rabbitmq_user_permissions<| |>
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
