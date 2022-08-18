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
  vpc_network_name = var.vpc_name

}

module "router_network" {
  source           = "./Module/router"
  for_each         = var.subnetworks
  router_name      = "router-${each.value.region_name}"
  region_name      = each.value.region_name
  vpc_network_name = var.vpc_name

}

module "nat" {
  source = "./Module/nat"
  for_each    = var.subnetworks
  nat_name = "nat-${each.value.region_name}"
  nat_router_name = "router-${each.value.region_name}"
  nat_region_name = each.value.region_name 
  #nat_router_name = module.router_network.router_name
  #nat_region_name = module.router_network.region_name
  #region_name = each.value.region_name
  #vpc_network_name = var.vpc_name

  depends_on = [
    module.router_network
  ]
}




