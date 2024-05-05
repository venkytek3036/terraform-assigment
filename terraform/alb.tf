module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "${local.prefix}-alb-${local.env}"
  vpc_id  = module.vpc_apps.vpc_id
  subnets = [module.vpc_apps.public_subnets[0], module.vpc_apps.public_subnets[1]]

  # Security Group
  security_group_ingress_rules = {
    all_ssh = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      description = "ssh traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "ex-instance"
      }
    }
  }

  target_groups = {
    ex-instance = {
      name_prefix = "v1"
      protocol    = "HTTP"
      target_type = "instance"
      target_id   = aws_instance.test.id
    }
  }

  tags = local.predefined-tags
}