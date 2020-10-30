###########################
###   INTERNET GATEWAY  ###
###########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.namespace}-igw"
    Environment = "dev"
  }
}

#######################
#######   EIP   #######
#######################

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

#######################
###   NAT GATEWAY   ###
#######################

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

###########################
### PUBLIC ROUTE TABLES ###
###########################

resource "aws_route_table" "pub_rt_a" {
  vpc_id = aws_vpc.main.id

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
  vpc_id = aws_vpc.main.id

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
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.namespace}-pub_rt_c"
    Environment = "dev"
  }
}

############################
### PRIVATE ROUTE TABLES ###
############################

resource "aws_route_table" "priv_rt_a" {
  vpc_id = aws_vpc.main.id

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
  vpc_id = aws_vpc.main.id

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
  vpc_id = aws_vpc.main.id

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
### PUBLIC ROUTE ASSOCIATIONS ###
#################################

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

##################################
### PRIVATE ROUTE ASSOCIATIONS ###
##################################

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