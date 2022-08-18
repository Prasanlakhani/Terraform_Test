project_name = "prasan-nirav"
#vpc_name     = "core-trusted"


vpc_name = "prasan-vpc-trusted"

subnetworks = {
  s1 = {
    subnet_name = "subnet1"
    ipaddress   = ["192.168.0.0/24"]
    region_name = "us-west1"
  }
  s2 = {
    subnet_name = "subnet2"
    ipaddress   = ["192.168.1.0/24"]
    region_name = "us-west2"
  }
  s3 = {
    subnet_name = "subnet3"
    ipaddress   = ["192.168.2.0/24"]
    region_name = "us-west3"
  }
}

