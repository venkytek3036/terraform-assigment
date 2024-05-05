##security-group##
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.prefix}-security-${local.env}"
  description = "EC2 server security group."
  vpc_id      = module.vpc_apps.vpc_id

  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_source_security_group_id = [
    {
      source_security_group_id = module.alb.security_group_id
      to_port                  = 22
      from_port                = 22
      protocol                 = "tcp"
    },
    {
      source_security_group_id = module.alb.security_group_id
      to_port                  = 80
      from_port                = 80
      protocol                 = "tcp"
    }
  ]
  ingress_with_self = [
    {
      self        = true
      description = "Allow access to self"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }
  ]
  egress_rules = ["all-all"]

  tags = local.predefined-tags
}

##iam-role-for-ec2##
resource "aws_iam_role" "test" {
  name = "${local.prefix}-ec2-${local.env}-instance-role"

  tags = local.predefined-tags

  assume_role_policy = <<-EOF
  {
  "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": ["ec2.amazonaws.com"]
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}
##instance-profile##
resource "aws_iam_instance_profile" "test-server" {
  depends_on = [
    aws_iam_role.test,
  ]
  name = "${local.prefix}-ec2-${local.env}-instance-profile"
  role = aws_iam_role.test.name
  tags = local.predefined-tags
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy_attachment" {
  depends_on = [
    aws_iam_role.test
  ]
  role       = aws_iam_role.test.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "keypair"
  public_key = tls_private_key.example.public_key_openssh
  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.example.private_key_pem}' > ~/keypair.pem && chmod 400 ~/keypair.pem"
  }
}

##EC2-machine##
resource "aws_instance" "test" {
  depends_on = [
    module.security_group,
    module.vpc_apps,
  ]

  ami                    = var.instances_ami
  instance_type          = "t3a.large"
  iam_instance_profile   = aws_iam_instance_profile.test-server.name
  key_name               = "keypair"
  subnet_id              = module.vpc_apps.private_subnets[0]
  vpc_security_group_ids = [module.security_group.security_group_id]
  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 20
    volume_type           = "gp3"
    tags                  = local.predefined-tags
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = local.predefined-tags
}