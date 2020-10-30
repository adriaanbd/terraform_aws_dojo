output "public_ip_a" {
  description = "THe Public IP of the Instance A"
  value       = aws_instance.bastion_host_a.public_ip
}

output "public_ip_b" {
  description = "THe Public IP of the Instance B"
  value       = aws_instance.bastion_host_b.public_ip
}

output "public_ip_c" {
  description = "THe Public IP of the Instance C"
  value       = aws_instance.bastion_host_c.public_ip
}

output "private_ip_a" {
  description = "The Private IP of the Instance A"
  value       = aws_instance.app_host_a.private_ip
}

output "pivate_ip_b" {
  description = "The Private IP of the Instance B"
  value       = aws_instance.app_host_b.private_ip
}

output "pivate_ip_c" {
  description = "The Private IP of the Instance C"
  value       = aws_instance.app_host_c.private_ip
}