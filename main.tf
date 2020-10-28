#########################
###     MAIN VPC      ###
#########################
resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cidr
  enable_dns_support    = true  # defaults to true
  enable_dns_hostnames  = true  # defaults to false

  tags = {
    Name        = "${var.namespace}-vpc"
    Environment = "dev"
  }
}

#########################
###     INTERNET      ###
#########################

###   INTERNET GATEWAY  ###

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.namespace}-igw"
    Environment = "dev"
  }
}

###   EIP   ###

resource "aws_eip" "nat_eip" {
  vpc         = true
  depends_on  = [aws_internet_gateway.igw]
  tags = {
    Name      = "${var.namespace}-nat_eip"
  }
}

###   NAT GATEWAY   ###

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub_a.id
  tags = {
    Name        = "${var.namespace}-ngw"
    Env         = "dev"
  }
}

#######################
###     SUBNETS     ###
#######################

###   PUBLIC  ###

resource "aws_subnet" "pub_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.namespace}-subnet"
    Environment = "dev"
  }
}

###   PRIVATE   ###

resource "aws_subnet" "app_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.priv_sub_cidr
  availability_zone       = var.az
  # if true, instances will be accessible via internet gateway
  map_public_ip_on_launch = false

  tags = {
    Name                  = "${var.namespace}-subnet-app_a"
    Environment           = "dev"
  }
}

###########################
###     ROUTE TABLES    ###
###########################

###   PUBLIC    ###

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.namespace}-rt"
    Environment = "dev"
  }
}

###   PRIVATE   ####

resource "aws_route_table" "app_a_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name        = "${var.namespace}-app_a_rt"
    Environment = "dev"
  }
}

#################################
###     ROUTE ASSOCIATIONS    ###
#################################

###   PUBLIC    ###

resource "aws_route_table_association" "rt-assoc" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.pub-rt.id
}

###   PRIVATE   ###

resource "aws_route_table_association" "app_a_rt_assoc" {
  subnet_id      = aws_subnet.app_a.id
  route_table_id = aws_route_table.app_a_rt.id
}

###########################
###   SECURITY GROUPS   ###
###########################

###   BASTION   ###

resource "aws_security_group" "bastion_sg" {
  name          = "bastion-sg"
  description   = "Allow SSH"
  vpc_id        = aws_vpc.main.id  # if not provided defaults to default VPC

  tags = {
    Name        = "${var.namespace}-sg"
    Environemnt = "dev"
  }
}

###     APP     ###

resource "aws_security_group" "app_a_sg" {
  name          = "app_a-sg"
  description   = "The Security "
  vpc_id        = aws_vpc.main.id

  tags = {
    Name        = "${var.namespace}-app_a-sg"
    Environemnt = "dev"
  }
}


################################
###   SECURITY GROUP RULES   ###
################################

#
###   INGRESS   ###
#

#     BASTION   #

resource "aws_security_group_rule" "ssh_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}

#      APP     #

resource "aws_security_group_rule" "ssh_from_jump" {
  type                      = "ingress"
  from_port                 = 22
  to_port                   = 22
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.bastion_sg.id
  security_group_id         = aws_security_group.app_a_sg.id
}

#
###   EGRESS    ###
#

#     BASTION   #

resource "aws_security_group_rule" "ssh_jump" {
  type                      = "egress"
  from_port                 = 22
  to_port                   = 22
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.app_a_sg.id
  security_group_id         = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_echo_request" {
  type              = "egress"
  # https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
  from_port         = 8  # echo request
  to_port           = 0  # echo reply
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}

#      APP     #

resource "aws_security_group_rule" "app_echo_request" {
  type              = "egress"
  from_port         = 8  # echo request
  to_port           = 0  # echo reply
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_a_sg.id
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

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.pub_a.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  tags = {
    Name        = "${var.namespace}-ec2"
    Environemnt = "dev"
  }
}

###   APP   ###

resource "aws_instance" "app_host" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.app_a.id
  vpc_security_group_ids = [aws_security_group.app_a_sg.id]
  tags = {
    Name                 = "${var.namespace}-ec2-app_host"
    Env                  = "dev"
  }
}
