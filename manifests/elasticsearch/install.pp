## Class profile::elasticsearch::install
#
# Actions: Installs Elastic Search
#
# Usage: just include it in your role. Configure values in Hiera.

class profile::elasticsearch::install (
  String $ensure                 = '',
  String $version                = '',
  String $status                 = '',
  String $repo_version           = '',
  String $datadir                = '/var/lib/elasticsearch-data',
  String $logdir                 = '/var/log/elasticsearch',
  String $configdir              = '/etc/elasticsearch',
  String $api_protocol           = 'http',
  String $api_host               = 'localhost',
  String $api_port               = '9200',
  String $cluster_name           = 'elasticsearch',
  String $jvm_heap_size          = '',
  String $max_locked_memory      = '',
  String $node_discovery_type    = '',
  Array $security_groups        = [],
  String $shards                 = '3',
  String $replicas               = '1',
  Boolean $bootstrap_memory_lock = true,
  String $network_host           = '',
  String $index_refresh_int      = '5s',
  String $aws_region             = '',
  ){

  #Estimate max heap size
  $maximum_heap_size = floor($::memorysize_mb / 2.0)
  if $maximum_heap_size > 30000 {
    $_maximum_heap_size = 30000
  }
  else {
    $_maximum_heap_size = $maximum_heap_size
  }
  $_jvm_heap_size = $jvm_heap_size ? {
    ''      => "${_maximum_heap_size}m",
    default => $jvm_heap_size,
  }


  class { 'elasticsearch' :
    ensure        => $ensure,
    version       => $version,
    manage_repo   => true,
    autoupgrade   => false,
    status        => $status,
    repo_version  => $repo_version,
    datadir       => $datadir,
    logdir        => $logdir,
    configdir     => $configdir,
    api_protocol  => $api_protocol,
    api_host      => $api_host,
    api_port      => $api_port,
    config        => {
      'cloud.aws.region'         => $aws_region,
      'cluster.name'             => $cluster_name,
      'discovery.type'           => $node_discovery_type,
      'discovery.ec2.groups'     => $security_groups,
      'index.number_of_shards'   => $shards,
      'index.number_of_replicas' => $replicas,
      'bootstrap.memory_lock'    => $bootstrap_memory_lock,
      'network.host'             => $network_host,
      'index.refresh_interval'   => $index_refresh_int,
      },
    init_defaults => {
      'ES_HEAP_SIZE'      => $_jvm_heap_size,
      'MAX_LOCKED_MEMORY' => $max_locked_memory,
    },
  }
}

