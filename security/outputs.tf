output "bastion_sg_a" {
  value = aws_security_group.bastion_sg_a.id
}

output "bastion_sg_b" {
  value = aws_security_group.bastion_sg_b.id
}

output "bastion_sg_c" {
  value = aws_security_group.bastion_sg_c.id
}

output "app_sg_a" {
  value = aws_security_group.app_sg_a.id
}

output "app_sg_b" {
  value = aws_security_group.app_sg_b.id
}

output "app_sg_c" {
  value = aws_security_group.app_sg_c.id
}

output "ecs_profile_id" {
  value = aws_iam_instance_profile.ecs_instance_profile.id
}

# output "ecs_service_role_name" {
#   value = aws_iam_role.ecs_role.name
# }

output "ecs_instance_profile_arn" {
  value = aws_iam_instance_profile.ecs_instance_profile.arn
}
