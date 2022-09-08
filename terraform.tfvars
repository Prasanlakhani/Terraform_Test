project_name = "prasan-nirav"
#vpc_name     = "core-trusted"


vpc_name = "prasan-vpc-trusted"

subnetworks = {
  s1 = {
    subnet_name = "subnet1"
    ipaddress   = ["192.168.0.0/24"]
    region_name = "us-west1"
  }
  s2 = {
    subnet_name = "subnet2"
    ipaddress   = ["192.168.1.0/24"]
    region_name = "us-west2"
  }
  s3 = {
    subnet_name = "subnet3"
    ipaddress   = ["192.168.2.0/24"]
    region_name = "us-west3"
  }
}

firewall = {
  "ssh_icmp" = {
    name     = "ssh-icmp"
    priority = 1000
    allow = {
      "icmp" = {
        protocol = "icmp"
        ports    = []
      }
      "tcp" = {
        protocol = "tcp"
        ports    = ["22", "80"]
      }
    }
    source_ranges = ["0.0.0.0"] # put your IP
  }
  "iap" = {
    name     = "iap"
    priority = 2000
    allow = {
      "iap" = {
        protocol = "tcp"
        ports    = []
      }
    }
    source_ranges = ["35.235.240.0/20"]
  }
  "health" = {
    name     = "health"
    priority = 3000
    allow = {
      "health" = {
        protocol = "tcp"
        ports    = ["80"]
      }
    }
    source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  }
}

health_check = {
  name                = "http-health-check"
  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  port_name           = "http"
  port                = 80
}

instance_template = {
  name_prefix  = "tf-"
  machine_type = "e2-micro"
  scheduling = {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }
  disk = {
    auto_delete = true
    boot        = true
  }
}

group_manager = {
  name                      = "tf-igm"
  base_instance_name        = "tf"
  region                    = "us-west1"
  distribution_policy_zones = ["us-west1-a", "us-west1-b", "us-west1-c"]
  target_size               = 3
  named_port = {
    name = "http"
    port = "80"
  }
  initial_delay_sec = 30
}

# Exercise 7.3 - Autoscaler
# instance_group.auto.tfvars

#autoscaler = {
#    name = "tf-autoscaler"
#    autoscaling_policy = {
#      max_replicas    = 3
#      min_replicas    = 1
#      cooldown_period = 30
#    }
#    cpu_utilization = {
#      target = 0.5
#    }
#}

# Exercise 10 - Workspaces
autoscaler = {
  "default" = {
    name = "tf-autoscaler"
    autoscaling_policy = {
      max_replicas    = 3
      min_replicas    = 1
      cooldown_period = 30
    }
    cpu_utilization = {
      target = 0.5
    }
  }
  "test" = {
    name = "tf-autoscaler"
    autoscaling_policy = {
      max_replicas    = 1
      min_replicas    = 1
      cooldown_period = 30
    }
    cpu_utilization = {
      target = 0.5
    }
  }
}

instance_boot_disk = {
  image_family  = "ubuntu-2004-lts"
  image_project = "ubuntu-os-cloud"
}

# Exercise 7.2 - Load balancer
# lb.auto.tfvars.tf

load_balancer = {
  backend_service = {
    name                  = "tf-backend-service"
    load_balancing_scheme = "EXTERNAL"
    protocol              = "HTTP"
    port_name             = "http"
  }
  url_map = {
    name = "tf-lb"
  }
  http_proxy = {
    name = "tf-http-proxy"
  }
  forwarding_rule = {
    name       = "tf-global-rule"
    port_range = "80"
  }
  network_tier = "PREMIUM"
}

# Exercise 11 - Cloud SQL
# sql.auto.tfvars.tf

database_instance = {
  database_version    = "MYSQL_8_0"
  region              = "us-west1"
  deletion_protection = false
  settings = {
    tier         = "db-f1-micro"
    ipv4_enabled = true
  }
}

sql_user = "prasanlakhani@gmail.com"

sql_database_name = "tf-db"

global_address = {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
}
