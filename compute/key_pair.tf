# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "my_key_file" {
  content     = tls_private_key.key.private_key_pem
  filename    = pathexpand("~/.ssh/${var.key_pair_name}.pem")
}