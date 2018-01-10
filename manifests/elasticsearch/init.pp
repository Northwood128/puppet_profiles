# Class: elasticsearch
# ===========================

class profile::elasticsearch {

  include profile::elasticsearch::install
  include profile::elasticsearch::instances
  include profile::elasticsearch::curator

}

