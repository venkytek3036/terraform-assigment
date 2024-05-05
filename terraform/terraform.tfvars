prefix                = "venky"
envType               = "develop"
profile               = "venky-test"
aws_region            = "ap-south-1"
multiple_nat_gateways = true
instances_ami         = "ami-089fdf62e986e93ea"

vpc_apps_cidr               = "172.22.0.0/16"
aws_availability_zone_names = ["ap-south-1a", "ap-south-1b"]
subnet_cidr = {
  aws_managed_services_subnets = {
    private = ["172.22.96.0/24", "172.22.97.0/24"]
    public  = ["172.22.99.0/24", "172.22.100.0/24"]
  }
}