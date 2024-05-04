output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.arn
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb.listener_rules
  sensitive   = true
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc_apps.vpc_id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.alb.security_group_id
}
