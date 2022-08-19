
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



