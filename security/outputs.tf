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