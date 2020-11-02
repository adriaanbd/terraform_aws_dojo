#######################
###   DATA SOURCE   ###
#######################

data "aws_ssm_parameter" "ami" {
  name = var.ami_ssm_param_name
}

#######################
###  EC2 INSTANCES  ###
#######################

###     BASTION     ###

resource "aws_instance" "bastion_host_a" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = var.pub_a_id
  vpc_security_group_ids = [var.bastion_sg_a]
  tags = {
    Name        = "${var.namespace}-bastion_a"
    Environemnt = "dev"
  }
}

resource "aws_instance" "bastion_host_b" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = var.pub_b_id
  vpc_security_group_ids = [var.bastion_sg_b]
  tags = {
    Name        = "${var.namespace}-bastion_b"
    Environemnt = "dev"
  }
}

resource "aws_instance" "bastion_host_c" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  subnet_id              = var.pub_c_id
  vpc_security_group_ids = [var.bastion_sg_c]
  tags = {
    Name        = "${var.namespace}-bastion_c"
    Environemnt = "dev"
  }
}

###        APP          ###

# resource "aws_instance" "app_host_a" {
#   ami                    = data.aws_ssm_parameter.ami.value
#   instance_type          = var.instance_type
#   key_name               = aws_key_pair.key_pair.key_name
#   subnet_id              = var.priv_a_id
#   vpc_security_group_ids = [var.app_sg_a_id]

#   tags = {
#     Name = "${var.namespace}-app_host_a"
#     Env  = "dev"
#   }
# }

# resource "aws_instance" "app_host_b" {
#   ami                    = data.aws_ssm_parameter.ami.value
#   instance_type          = var.instance_type
#   key_name               = aws_key_pair.key_pair.key_name
#   subnet_id              = var.priv_b_id
#   vpc_security_group_ids = [var.app_sg_b_id]

#   tags = {
#     Name = "${var.namespace}-app_host_b"
#     Env  = "dev"
#   }
# }

# resource "aws_instance" "app_host_c" {
#   ami                    = data.aws_ssm_parameter.ami.value
#   instance_type          = var.instance_type
#   key_name               = aws_key_pair.key_pair.key_name
#   subnet_id              = var.priv_c_id
#   vpc_security_group_ids = [var.app_sg_c_id]

#   tags = {
#     Name = "${var.namespace}-app_host_c"
#     Env  = "dev"
#   }
# }
