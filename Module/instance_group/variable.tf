# Exercise 8 - Modules
# instance_group/instance_group_var.tf

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

variable "autoscaler" {
  type = object({
    name = string
    autoscaling_policy = object({
      max_replicas    = number
      min_replicas    = number
      cooldown_period = number
    })
    cpu_utilization = object({
      target = number
    })
  })
}

variable "network_interface" {
  type = object({
    network_id    = string
    subnetwork_id = string
  })
}

variable "instance_boot_disk" {
  type = map(string)
}

variable "public-ssh-key" { # local replaced with variable
  type = string
}
