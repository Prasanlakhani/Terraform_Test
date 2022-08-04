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
