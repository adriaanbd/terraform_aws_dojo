resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cidr
  enable_dns_support    = true  # defaults to true
  enable_dns_hostnames  = true  # defaults to false

  tags = {
    Name        = "${var.namespace}-vpc"
    Environment = "dev"
  }
}

resource "aws_subnet" "main" {
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
  subnet_id      = aws_subnet.main.id
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

resource "aws_instance" "bastion_host" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags = {
    Name        = "${var.namespace}-ec2"
    Environemnt = "dev"
  }
}


