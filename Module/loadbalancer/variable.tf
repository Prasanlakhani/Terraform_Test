# Exercise 8 - Modules
# lb/lb_var.tf

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

variable "health_check_id" {
  type = string
}

variable "instance_group" {
  type = string
}
