#######################
### PUBLIC SUBNETS  ###
#######################

resource "aws_subnet" "pub_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.namespace}-pub_subnet_a"
    Environment = "dev"
  }
}

resource "aws_subnet" "pub_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.namespace}-pub_subnet_b"
    Environment = "dev"
  }
}

resource "aws_subnet" "pub_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_c_cidr
  availability_zone       = var.az_c
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.namespace}-pub_subnet_c"
    Environment = "dev"
  }
}

#######################
###   APP SUBNETS   ###
#######################

resource "aws_subnet" "priv_sub_app_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.priv_sub_app_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false # accessible via internet gateway

  tags = {
    Name        = "${var.namespace}-priv_sub_app_a"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_app_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.priv_sub_app_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_app_b"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_app_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.priv_sub_app_c_cidr
  availability_zone       = var.az_c
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_app_c"
    Environment = "dev"
  }
}

#######################
###   DDBB SUBNETS  ###
#######################

resource "aws_subnet" "priv_sub_ddbb_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.priv_sub_ddbb_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false # accessible via internet gateway

  tags = {
    Name        = "${var.namespace}-priv_sub_ddbb_a"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_ddbb_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.priv_sub_ddbb_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_ddbb_b"
    Environment = "dev"
  }
}

resource "aws_subnet" "priv_sub_ddbb_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.priv_sub_ddbb_c_cidr
  availability_zone       = var.az_c
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.namespace}-priv_sub_ddbb_c"
    Environment = "dev"
  }
}

