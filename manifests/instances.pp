class profile_elasticsearch::instance (

  String $instance_name          = '',
  String $instance_config        = '',
  String $instance_init_defaults = '',
  Array $additional_plugins      = [],
  String $plugin_ensure          = '',

){

  elasticsearch::instance { $instance_name:
    config        => $instance_config,
    init_defaults => $instance_init_defaults,
  }

  $additional_plugins.each |$plugin| {
    elasticsearch::plugin { $plugin:
      ensure    => $plugin_ensure,
      instances => $instance_name,
    }
  }

}

