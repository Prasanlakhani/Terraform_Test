output "vpc_out" {
  value = module.vpc.vpc_out
}

output "subnet_out" {
  value = module.subnetwork#["*"].id
}

#output "subnet_region_out" {
#  value = module.subnetwork["*"].region
#}