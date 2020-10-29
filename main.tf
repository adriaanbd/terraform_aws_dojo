module "network" {
  type   = string
  source = "./network"
}

#########################
###     INTERNET      ###
#########################

###   INTERNET GATEWAY  ###

resource "aws_internet_gateway" "igw" {
  vpc_id = module.network.vpc_id

  tags = {
    Name        = "${var.namespace}-igw"
    Environment = "dev"
  }
}

###   EIP   ###

resource "aws_eip" "nat_eip_a" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.namespace}-nat_eip_a"
  }
}

resource "aws_eip" "nat_eip_b" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.namespace}-nat_eip_b"
  }
}

resource "aws_eip" "nat_eip_c" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.namespace}-nat_eip_c"
  }
}

###   NAT GATEWAY   ###

resource "aws_nat_gateway" "ngw_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.pub_a.id
  tags = {
    Name = "${var.namespace}-ngw_a"
    Env  = "dev"
  }
}

resource "aws_nat_gateway" "ngw_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.pub_b.id
  tags = {
    Name = "${var.namespace}-ngw_b"
    Env  = "dev"
  }
}

resource "aws_nat_gateway" "ngw_c" {
  allocation_id = aws_eip.nat_eip_c.id
  subnet_id     = aws_subnet.pub_c.id
  tags = {
    Name = "${var.namespace}-ngw_c"
    Env  = "dev"
  }
}

#######################
###     SUBNETS     ###
#######################

#               #
###   PUBLIC  ###
#               #

resource "aws_subnet" "pub_a" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.pub_sub_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.namespace}-pub_subnet_a"
    Environment = "dev"
  }
}

resource "aws_subnet" "pub_b" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.pub_sub_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.namespace}-pub_subnet_b"
    Environment = "dev"
  }
}

resource "aws_subnet" "pub_c" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.pub_sub_c_cidr
  availability_zone       = var.az_c
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.namespace}-pub_subnet_c"
    Environment = "dev"
  }
}

#                 #
###   PRIVATE   ###
#                 #

###  APP LAYER   ###

resource "aws_subnet" "priv_sub_app_a" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.priv_sub_app_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false # accessible via internet gateway

  tags = {
    Name        = "${var.namespace}-priv_sub_app_a"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_app_b" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.priv_sub_app_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_app_b"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_app_c" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.priv_sub_app_c_cidr
  availability_zone       = var.az_c
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_app_c"
    Environment = "dev"
  }
}

###  DATA LAYER   ###

resource "aws_subnet" "priv_sub_ddbb_a" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.priv_sub_ddbb_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false # accessible via internet gateway

  tags = {
    Name        = "${var.namespace}-priv_sub_ddbb_a"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_ddbb_b" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.priv_sub_ddbb_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_ddbb_b"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_ddbb_c" {
  vpc_id                  = module.network.vpc_id
  cidr_block              = var.priv_sub_ddbb_c_cidr
  availability_zone       = var.az_c
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_ddbb_c"
    Environment = "dev"
  }
}

###########################
###     ROUTE TABLES    ###
###########################

###   PUBLIC    ###

resource "aws_route_table" "pub_rt_a" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.namespace}-pub_rt_a"
    Environment = "dev"
  }
}

resource "aws_route_table" "pub_rt_b" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.namespace}-pub_rt_b"
    Environment = "dev"
  }
}

resource "aws_route_table" "pub_rt_c" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.namespace}-pub_rt_c"
    Environment = "dev"
  }
}

###   PRIVATE   ####

resource "aws_route_table" "priv_rt_a" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_a.id
  }

  tags = {
    Name        = "${var.namespace}-priv_rt_a"
    Environment = "dev"
  }
}

resource "aws_route_table" "priv_rt_b" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_b.id
  }

  tags = {
    Name        = "${var.namespace}-priv_rt_b"
    Environment = "dev"
  }
}

resource "aws_route_table" "priv_rt_c" {
  vpc_id = module.network.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_c.id
  }

  tags = {
    Name        = "${var.namespace}-priv_rt_c"
    Environment = "dev"
  }
}

#################################
###     ROUTE ASSOCIATIONS    ###
#################################

###           PUBLIC          ###

resource "aws_route_table_association" "rt_assoc_a" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.pub_rt_a.id
}

resource "aws_route_table_association" "rt_assoc_b" {
  subnet_id      = aws_subnet.pub_b.id
  route_table_id = aws_route_table.pub_rt_b.id
}

resource "aws_route_table_association" "rt_assoc_c" {
  subnet_id      = aws_subnet.pub_c.id
  route_table_id = aws_route_table.pub_rt_c.id
}

###           PRIVATE         ###

resource "aws_route_table_association" "priv_rt_assoc_a" {
  subnet_id      = aws_subnet.priv_sub_app_a.id
  route_table_id = aws_route_table.priv_rt_a.id
}

resource "aws_route_table_association" "priv_rt_assoc_b" {
  subnet_id      = aws_subnet.priv_sub_app_b.id
  route_table_id = aws_route_table.priv_rt_b.id
}

resource "aws_route_table_association" "priv_rt_assoc_c" {
  subnet_id      = aws_subnet.priv_sub_app_c.id
  route_table_id = aws_route_table.priv_rt_c.id
}

###########################
###   SECURITY GROUPS   ###
###########################

###   BASTION   ###

resource "aws_security_group" "bastion_sg_a" {
  name        = "bastion_sg_a"
  description = "The Security Group of the Bastion Host"
  vpc_id      = module.network.vpc_id

  tags = {
    Name        = "${var.namespace}-bastion_sg_a"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "bastion_sg_b" {
  name        = "bastion_sg_b"
  description = "The Security Group of the Bastion Host"
  vpc_id      = module.network.vpc_id

  tags = {
    Name        = "${var.namespace}-bastion_sg_b"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "bastion_sg_c" {
  name        = "bastion_sg_c"
  description = "The Security Group of the Bastion Host"
  vpc_id      = module.network.vpc_id

  tags = {
    Name        = "${var.namespace}-bastion_sg_c"
    Environemnt = "dev"
  }
}

###     APP     ###

resource "aws_security_group" "app_sg_a" {
  name        = "app_sg_a"
  description = "The Security Group of the App"
  vpc_id      = module.network.vpc_id

  tags = {
    Name        = "${var.namespace}-app_sg_a"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "app_sg_b" {
  name        = "app_sg_b"
  description = "The Security Group of the App"
  vpc_id      = module.network.vpc_id

  tags = {
    Name        = "${var.namespace}-app_sg_b"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "app_sg_c" {
  name        = "app_sg_c"
  description = "The Security Group of the App"
  vpc_id      = module.network.vpc_id

  tags = {
    Name        = "${var.namespace}-app_sg_c"
    Environemnt = "dev"
  }
}

################################
###   SECURITY GROUP RULES   ###
################################

#                 #
###   INGRESS   ###
#                 #

#     BASTION     #

resource "aws_security_group_rule" "ssh_bastion_a" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg_a.id
}

resource "aws_security_group_rule" "ssh_bastion_b" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg_b.id
}

resource "aws_security_group_rule" "ssh_bastion_c" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg_c.id
}

#      APP     #

resource "aws_security_group_rule" "ssh_from_jump_a" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg_a.id
  security_group_id        = aws_security_group.app_sg_a.id
}

resource "aws_security_group_rule" "ssh_from_jump_b" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg_b.id
  security_group_id        = aws_security_group.app_sg_b.id
}

resource "aws_security_group_rule" "ssh_from_jump_c" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_sg_c.id
  security_group_id        = aws_security_group.app_sg_c.id
}

#
###   EGRESS    ###
#

#    BASTION SSH  #

resource "aws_security_group_rule" "ssh_jump_a" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg_a.id
  security_group_id        = aws_security_group.bastion_sg_a.id
}

resource "aws_security_group_rule" "ssh_jump_b" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg_b.id
  security_group_id        = aws_security_group.bastion_sg_b.id
}

resource "aws_security_group_rule" "ssh_jump_c" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg_c.id
  security_group_id        = aws_security_group.bastion_sg_c.id
}

#   BASTION ECHO REQUEST    #

resource "aws_security_group_rule" "bastion_ping_a" {
  type = "egress"
  # https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
  from_port         = 8 # echo request
  to_port           = 0 # echo reply
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg_a.id
}

resource "aws_security_group_rule" "bastion_ping_b" {
  type              = "egress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg_b.id
}

resource "aws_security_group_rule" "bastion_ping_c" {
  type              = "egress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg_c.id
}

#      APP ECHO REQUEST    #

resource "aws_security_group_rule" "app_ping_a" {
  type              = "egress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_a.id
}

resource "aws_security_group_rule" "app_ping_b" {
  type              = "egress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_b.id
}

resource "aws_security_group_rule" "app_ping_c" {
  type              = "egress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_c.id
}

resource "aws_security_group_rule" "app_http_a" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_a.id
}

resource "aws_security_group_rule" "app_http_b" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_b.id
}

resource "aws_security_group_rule" "app_http_c" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_c.id
}

#######################
###   DATA SOURCE   ###
#######################

data "aws_ssm_parameter" "ami" {
  name = var.ami
}

#######################
###  EC2 INSTANCES  ###
#######################

###   BASTION   ###

resource "aws_instance" "bastion_host_a" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.pub_a.id
  vpc_security_group_ids = [aws_security_group.bastion_sg_a.id]
  tags = {
    Name        = "${var.namespace}-bastion_a"
    Environemnt = "dev"
  }
}

resource "aws_instance" "bastion_host_b" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.pub_b.id
  vpc_security_group_ids = [aws_security_group.bastion_sg_b.id]
  tags = {
    Name        = "${var.namespace}-bastion_b"
    Environemnt = "dev"
  }
}

resource "aws_instance" "bastion_host_c" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.pub_c.id
  vpc_security_group_ids = [aws_security_group.bastion_sg_c.id]
  tags = {
    Name        = "${var.namespace}-bastion_c"
    Environemnt = "dev"
  }
}

###   APP   ###

resource "aws_instance" "app_host_a" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.priv_sub_app_a.id
  vpc_security_group_ids = [aws_security_group.app_sg_a.id]
  tags = {
    Name = "${var.namespace}-app_host_a"
    Env  = "dev"
  }
}

resource "aws_instance" "app_host_b" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.priv_sub_app_b.id
  vpc_security_group_ids = [aws_security_group.app_sg_b.id]
  tags = {
    Name = "${var.namespace}-app_host_b"
    Env  = "dev"
  }
}

resource "aws_instance" "app_host_c" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.priv_sub_app_c.id
  vpc_security_group_ids = [aws_security_group.app_sg_c.id]
  tags = {
    Name = "${var.namespace}-app_host_c"
    Env  = "dev"
  }
}
