# Exercise 8 - Modules
# firewall/firewall_var.tf

variable "firewall" {
  type = object({
    name     = string
    priority = number
    allow = map(object({
      protocol = string
      ports    = list(string)
    }))
    source_ranges = list(string)
  })
}

variable "network_id" {
  type = string
}
