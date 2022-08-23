# Exercise 3.4 -Random provider
# main.tf

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.5"


    }
  }

}

provider "google" {
  project = var.project_name
  #region  = var.region_name
  #credentials = var.GOOGLE_CREDENTIALS

}

terraform {
  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "prasanlakhani"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "Test-workspace"
    }
  }
}

module "vpc" {
  source       = "./Module/vpc"
  vpc_name     = var.vpc_name
  project_name = var.project_name
}

module "subnetwork" {
  source      = "./Module/subnet"
  for_each    = var.subnetworks
  subnet_name = "subnet-${each.value.region_name}"
  #subnet_name = each.value.subnet_name
  ipaddress   = each.value.ipaddress
  region_name = each.value.region_name
  #vpc_network_name = google_compute_network.vpc_network.name
  #vpc_network_name =  module.vpc.name
  vpc_network_name = module.vpc.vpc_out

}


#module "router_network" {
#  source           = "./Module/router"
#  for_each         = var.subnetworks
#  router_name      = "router-${each.value.region_name}"
#  region_name      = each.value.region_name
#  vpc_network_name = var.vpc_name

#}

#module "nat" {
#  source          = "./Module/nat"
#  for_each        = var.subnetworks
#  nat_name        = "nat-${each.value.region_name}"
#  nat_router_name = "router-${each.value.region_name}"
#  nat_region_name = each.value.region_name
#  #nat_router_name = module.router_network.router_name
#  #nat_region_name = module.router_network.region_name
#  #region_name = each.value.region_name
#  #vpc_network_name = var.vpc_name



#}

#output "network_id" {
#  value = module.vpc.self_link
#}

#output "subnetworks" {
#  value = module.subnetwork[*].name
##}



