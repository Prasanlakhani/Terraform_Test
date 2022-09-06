# Exercise 11 - Cloud SQL
# sql/sql_var.tf

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

variable "network_id" {
  type = string
}
