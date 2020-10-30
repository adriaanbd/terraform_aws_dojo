output "vpc_id" {
  description = "The ID of the Main VPC"
  value       = module.network.vpc_id
}

output "pub_a_id" {
  description = "The ID of the Public Subnet A"
  value       = module.network.pub_a_id
}

output "pub_b_id" {
  description = "The ID of the Public Subnet A"
  value       = module.network.pub_b_id
}

output "pub_c_id" {
  description = "The ID of the Public Subnet A"
  value       = module.network.pub_c_id
}

output "priv_app_a_id" {
  description = "The ID of the Subnet of App A"
  value       = module.network.priv_a_id
}

output "priv_app_b_id" {
  description = "The ID of the Subnet of App B"
  value       = module.network.priv_b_id
}

output "priv_app_c_id" {
  description = "The ID of the Subnet of App C"
  value       = module.network.priv_c_id
}

output "bastion_ip_a" {
  description = "The Public IP of the Instance A"
  value       = module.compute.public_ip_a
}

output "bastion_ip_b" {
  description = "The Public IP of the Instance B"
  value       = module.compute.public_ip_b
}

output "bastion_ip_c" {
  description = "The Public IP of the Instance C"
  value       = module.compute.public_ip_c
}

# output "app_ip_a" {
#   description = "The Private IP of the Instance A"
#   value       = module.compute.private_ip_a
# }

# output "app_ip_b" {
#   description = "The Private IP of the Instance B"
#   value       = module.compute.private_ip_b
# }

# output "app_ip_c" {
#   description = "The Private IP of the Instance C"
#   value       = module.compute.private_ip_c
# }
