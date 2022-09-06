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
  source           = "./Module/subnet"
  for_each         = var.subnetworks
  subnet_name      = "subnet-${each.value.region_name}"
  ipaddress        = each.value.ipaddress
  region_name      = each.value.region_name
  vpc_network_name = module.vpc.vpc_out

}


module "router_network" {
  source           = "./Module/router"
  for_each         = var.subnetworks
  router_name      = "router-${each.value.region_name}"
  region_name      = each.value.region_name
  vpc_network_name = module.vpc.vpc_out
}

module "nat" {
  source          = "./Module/nat"
  for_each        = var.subnetworks
  nat_name        = "nat-${each.value.region_name}"
  nat_router_name = "router-${each.value.region_name}"
  nat_region_name = each.value.region_name

}

#output "network_id" {
#  value = module.vpc.self_link
#}

#output "subnetworks" {
#  value = module.subnetwork[*].name
##}


module "firewall" {
  source = "./Module/firewall"

  for_each = var.firewall

  firewall   = each.value
  network_id = module.vpc.vpc_out
}


# Exercise 8 - Modules
# instance_group.tf

data "google_compute_image" "this" {
  family  = var.instance_boot_disk.image_family
  project = var.instance_boot_disk.image_project
}

module "instance_group" {
  source = "./Module/instance_group"

  health_check      = var.health_check
  instance_template = var.instance_template
  group_manager     = var.group_manager
  autoscaler        = var.autoscaler.default
  #autoscaler         = var.autoscaler #[terraform.workspace]
  instance_boot_disk = var.instance_boot_disk
  public-ssh-key     = local.public-ssh-key
  network_interface = {
    #network_id    = data.terraform_remote_state.vpc.outputs.vpc_out
    #subnetwork_id = data.terraform_remote_state.network.outputs.subnetworks["s1"].id
    #network_id = module.subnetwork["s1"].google_compute_subnetwork.subnet.network
    network_id    = module.vpc.vpc_out
    subnetwork_id = module.subnetwork["s1"].subnet_out.name #module.subnetwork.subnet_out["s1"].name
    #network_id    = data.terraform_remote_state.network.outputs.network_id
    #subnetwork_id = data.terraform_remote_state.network.outputs.subnetworks["s1"].id

  }
}

# Exercise 8 - Modules
# lb.tf

module "lb" {
  source = "./Module/loadbalancer"

  load_balancer   = var.load_balancer
  health_check_id = module.instance_group.health_check_id
  instance_group  = module.instance_group.instance_group
}

# Exercise 11 - Cloud SQL
# sql.tf

module "sql" {
  source = "./Module/sql"

  database_instance = var.database_instance
  sql_user          = var.sql_user
  sql_database_name = var.sql_database_name
  global_address    = var.global_address
  #network_id        = data.terraform_remote_state.network.outputs.network_id
  #network_id = module.subnetwork["s1"].google_compute_subnetwork.subnet.network
  network_id = module.vpc.vpc_out
}
