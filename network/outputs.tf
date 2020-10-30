output "vpc_id" {
  description = "The ID of the Main VPC"
  value       = aws_vpc.main.id
}

output "pub_a_id" {
  description = "The ID of the Public Subnet A"
  value       = aws_subnet.pub_a.id
}

output "pub_b_id" {
  description = "The ID of the Public Subnet A"
  value       = aws_subnet.pub_b.id
}

output "pub_c_id" {
  description = "The ID of the Public Subnet A"
  value       = aws_subnet.pub_c.id
}

output "priv_sub_app_a_id" {
  description = "The ID of the Subnet of App A"
  value       = aws_subnet.priv_sub_app_a.id
}

output "piv_sub_app_b_id" {
  description = "The ID of the Subnet of App B"
  value       = aws_subnet.priv_sub_app_b.id
}

output "piv_sub_app_c_id" {
  description = "The ID of the Subnet of App C"
  value       = aws_subnet.priv_sub_app_c.id
}
