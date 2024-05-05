locals {
  predefined-tags = {
    TechnologyUnit = "Infra"
    Project        = "test"
    Environment    = local.env
    Owner          = "venky3036@gmail.com"
    Team           = "Devops"
  }
}

locals {
  prefix = "${var.prefix}apps"
  env    = var.envType
}