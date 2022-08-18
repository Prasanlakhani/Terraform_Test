#variable "subnetworks" {
#  type = map(object({
#    subnet_name = string
#    ipaddress   = string
#    region_name = string
#  }))
#  description = "The ID of the project where this VPC will be created"
#}

variable "subnet_name" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "ipaddress" {
  type        = list(string)
  description = "The ID of the project where this VPC will be created"
}

variable "region_name" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "vpc_network_name" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}