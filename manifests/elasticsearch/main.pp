# Class: elasticsearch
# ===========================

class profile::elasticsearch::main {

  include profile::elasticsearch::install
  include profile::elasticsearch::instances
  include profile::elasticsearch::curator

}

