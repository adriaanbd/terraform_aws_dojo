output "vpc_id" {
  description = "The ID of the Main VPC"
  value       = aws_vpc.main.id
}
