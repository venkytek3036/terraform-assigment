<!-- BEGIN_TF_DOCS -->
## Overview

This setup uses Terraform to create important parts of an AWS environment for running applications. It includes:

# ALB (Application Load Balancer): 
This spreads incoming web traffic evenly across different parts of your application.
# Security Group: 
Think of this as a virtual firewall for your servers, allowing only specific types of traffic in and out.
# IAM Role: 
This gives your servers permission to do certain tasks within AWS, like accessing other services.
# Key Pair: 
It's like a digital lock and key for accessing your servers remotely.
# EC2 Instance: 
This is your virtual server where your application runs.
# VPC (Virtual Private Cloud): 
This is like your private network in AWS, where you can place your servers and control how they connect to the internet.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.48.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | n/a |
| <a name="module_vpc_apps"></a> [vpc\_apps](#module\_vpc\_apps) | terraform-aws-modules/vpc/aws | 5.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.test-server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ssm_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.generated_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [tls_private_key.example](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_availability_zone_names"></a> [aws\_availability\_zone\_names](#input\_aws\_availability\_zone\_names) | Provide availability zone names | `list(string)` | <pre>[<br>  "ap-south-1a",<br>  "ap-south-1b"<br>]</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Provide region name | `string` | `"ap-south-1"` | no |
| <a name="input_envType"></a> [envType](#input\_envType) | n/a | `string` | `"dev"` | no |
| <a name="input_instances_ami"></a> [instances\_ami](#input\_instances\_ami) | AMI ID to be used for the server | `string` | `"ami-036490d46656c4818"` | no |
| <a name="input_multiple_nat_gateways"></a> [multiple\_nat\_gateways](#input\_multiple\_nat\_gateways) | Enable multiple NAT gateways | `bool` | `false` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | #variables## | `string` | `"venky"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | n/a | `string` | n/a | yes |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | Subnet CIDR block for eks and aws subnets | <pre>object({<br>    aws_managed_services_subnets = object({<br>      private = list(string)<br>      public  = list(string)<br>    })<br>  })</pre> | <pre>{<br>  "aws_managed_services_subnets": {<br>    "private": [<br>      "172.22.96.0/24",<br>      "172.22.97.0/24"<br>    ],<br>    "public": [<br>      "172.22.99.0/24",<br>      "172.22.100.0/24"<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_vpc_apps_cidr"></a> [vpc\_apps\_cidr](#input\_vpc\_apps\_cidr) | CIDR block for vpc, which is the main vpc holding app-related cluster resources | `string` | `"172.22.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ID and ARN of the load balancer we created |
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The DNS name of the load balancer |
| <a name="output_id"></a> [id](#output\_id) | The ID and ARN of the load balancer we created |
| <a name="output_listener_rules"></a> [listener\_rules](#output\_listener\_rules) | Map of listeners rules created and their attributes |
| <a name="output_listeners"></a> [listeners](#output\_listeners) | Map of listeners created and their attributes |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | n/a |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the security group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->