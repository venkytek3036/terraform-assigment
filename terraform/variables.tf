##variables##
variable "prefix" {
  type    = string
  default = "venky"
}

variable "envType" {
  type    = string
  default = "dev"
}

variable "vpc_apps_cidr" {
  description = "CIDR block for vpc, which is the main vpc holding app-related cluster resources"
  type        = string
  default     = "172.22.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block for eks and aws subnets"
  type = object({
    aws_managed_services_subnets = object({
      private = list(string)
      public  = list(string)
    })
  })
  default = {
    aws_managed_services_subnets = {
      private = ["172.22.96.0/24", "172.22.97.0/24"]
      public  = ["172.22.99.0/24", "172.22.100.0/24"]
    }
  }
}

variable "multiple_nat_gateways" {
  description = "Enable multiple NAT gateways"
  type        = bool
  default     = false
}

variable "aws_availability_zone_names" {
  description = "Provide availability zone names"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "aws_region" {
  description = "Provide region name"
  type        = string
  default     = "ap-south-1"
}

variable "profile" {
  type = string
}

variable "instances_ami" {
  description = "AMI ID to be used for the server"
  type        = string
  default     = "ami-036490d46656c4818"
}