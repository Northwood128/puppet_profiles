# Class: elasticsearch
# ===========================

class profile_elasticsearch {

  include profile::elasticsearch::install
  include profile::elasticsearch::instances
  include profile::elasticsearch::curator

}

