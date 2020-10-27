resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cidr
  enable_dns_support    = true  # defaults to true
  enable_dns_hostnames  = true  # defaults to false

  tags = {
    Name        = "${var.namespace}-vpc"
    Environment = "dev"
  }
}

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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.namespace}-igw"
    Environment = "dev"
  }
}

resource "aws_route_table" "rt" {
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

resource "aws_route_table_association" "rt-assoc" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "ec2_sg" {
  name          = "bastion-sg"
  description   = "Allow SSH"
  vpc_id        = aws_vpc.main.id  # if not provided defaults to default VPC

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    # https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    from_port   = 8  # from icmp parameter type "Echo"
    to_port     = 0  # from icmp parameter type "Echo Reply"
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.namespace}-sg"
    Environemnt = "dev"
  }
}

data "aws_ssm_parameter" "ami" {
  name = var.ami
}

resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.pub_a.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name        = "${var.namespace}-ec2"
    Environemnt = "dev"
  }
}

resource "aws_eip" "nat_eip" {
  vpc         = true
  depends_on  = [aws_internet_gateway.igw]
  tags = {
    Name      = "${var.namespace}-nat_eip"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub_a.id
  tags = {
    Name        = "${var.namespace}-ngw"
    Env         = "dev"
  }
}

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

resource "aws_route_table" "app_a-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name        = "${var.namespace}-app_a-rt"
    Environment = "dev"
  }
}

resource "aws_route_table_association" "app_a-rt_assoc" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "app_a-sg" {
  name          = "app_a-sg"
  description   = "Allow SSH"
  vpc_id        = aws_vpc.main.id  # if not provided defaults to default VPC

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    # https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    from_port   = 8  # from icmp parameter type "Echo"
    to_port     = 0  # from icmp parameter type "Echo Reply"
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.namespace}-app_a-sg"
    Environemnt = "dev"
  }
}

resource "aws_instance" "app_host" {
  ami                    = data.aws_ssm_parameter.ami.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.pub_a.id
  vpc_security_group_ids = [aws_security_group.app_a-sg.id]
  tags = {
    Name                 = "${var.namespace}-ec2-app_host"
    Env                  = "dev"
  }
}
