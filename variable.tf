
#variable "GOOGLE_CREDENTIALS" {
#default= ""
#}

variable "project_name" {
  type = string
  #default     = "prasan-nirav"
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The name of the VPC being created"
}



variable "vpc_name" {
  description = "List with bucket names"
  type        = string
}

variable "subnetworks" {
  type = map(object({
    subnet_name = string
    ipaddress   = list(string)
    region_name = string
  }))
  description = "The ID of the project where this VPC will be created"
}


#variable "ipaddress" {
#  type        = string
#  description = "The ID of the project where this VPC will be created"
#}

#variable "region_name" {
#  type        = string
#  description = "The ID of the project where this VPC will be created"
#}

# Exercise 6 - Code splitting
# firewall_var.tf

variable "firewall" {
  type = map(object({
    name     = string
    priority = number
    allow = map(object({
      protocol = string
      ports    = list(string)
    }))
    source_ranges = list(string)
  }))
}

variable "health_check" {
  type = object({
    name                = string
    timeout_sec         = number
    check_interval_sec  = number
    healthy_threshold   = number
    unhealthy_threshold = number
    port_name           = string
    port                = number
  })
}

variable "instance_template" {
  type = object({
    name_prefix  = string
    machine_type = string
    scheduling = object({
      automatic_restart   = bool
      on_host_maintenance = string
    })
    disk = object({
      auto_delete = bool
      boot        = bool
    })
  })
}

variable "group_manager" {
  type = object({
    name                      = string
    base_instance_name        = string
    region                    = string
    distribution_policy_zones = list(string)
    target_size               = number
    named_port = object({
      name = string
      port = number
    })
    initial_delay_sec = number
  })
}

# Exercise 7.3 - Autoscaler
# instance_group_var.tf

#variable "autoscaler" {
#  type = object({
#    name = string
#    autoscaling_policy = object({
#      max_replicas    = number
#      min_replicas    = number
#      cooldown_period = number
#    })
#    cpu_utilization = object({
#      target = number
#    })
#  })
#}

# Exercise 10 - Workspaces
variable "autoscaler" {
  type = map(object({
    name = string
    autoscaling_policy = object({
      max_replicas    = number
      min_replicas    = number
      cooldown_period = number
    })
    cpu_utilization = object({
      target = number
    })
  }))
}

locals {
  public-ssh-key = "<user>:ssh-rsa ..."
}

variable "instance_boot_disk" {
  type = map(string)
}

# Exercise 7.2 - Load balancer
# lb_var.tf

variable "load_balancer" {
  type = object({
    backend_service = object({
      name                  = string
      load_balancing_scheme = string
      protocol              = string
      port_name             = string
    })
    url_map = object({
      name = string
    })
    http_proxy = object({
      name = string
    })
    forwarding_rule = object({
      name       = string
      port_range = string
    })
    network_tier = string
  })
}


# Exercise 11 - Cloud SQL
# sql_var.tf.tf

variable "database_instance" {
  type = object({
    database_version    = string
    region              = string
    deletion_protection = bool
    settings = object({
      tier         = string
      ipv4_enabled = bool
    })
  })
}

variable "sql_user" {
  type = string
}

variable "sql_database_name" {
  type = string
}

variable "global_address" {
  type = object({
    name          = string
    purpose       = string
    address_type  = string
    prefix_length = number
  })
}


