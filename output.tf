output "vpc_out" {
  value = module.vpc.vpc_out
}

output "subnet_out" {
  value = module.subnetwork
  #value = toset(values(module.subnetwork)[*].region)
}

#value = toset(values(aws_instance.ubuntu)[*].arn)

#output "subnet_region_out" {
#  value = module.subnetwork[*].google_compute_subnetwork.subnet.region
#}

output "subnet_out_s1" {
  value = module.subnetwork["s1"].subnet_out.id
  #value = toset(values(module.subnetwork)[*].region)
}