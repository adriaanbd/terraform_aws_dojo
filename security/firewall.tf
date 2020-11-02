###########################
###   SECURITY GROUPS   ###
###########################

###   BASTION   ###

resource "aws_security_group" "bastion_sg_a" {
  name        = "bastion_sg_a"
  description = "The Security Group of the Bastion Host"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.namespace}-bastion_sg_a"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "bastion_sg_b" {
  name        = "bastion_sg_b"
  description = "The Security Group of the Bastion Host"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.namespace}-bastion_sg_b"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "bastion_sg_c" {
  name        = "bastion_sg_c"
  description = "The Security Group of the Bastion Host"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.namespace}-bastion_sg_c"
    Environemnt = "dev"
  }
}

###     APP     ###

resource "aws_security_group" "app_sg_a" {
  name        = "app_sg_a"
  description = "The Security Group of the App"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.namespace}-app_sg_a"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "app_sg_b" {
  name        = "app_sg_b"
  description = "The Security Group of the App"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.namespace}-app_sg_b"
    Environemnt = "dev"
  }
}

resource "aws_security_group" "app_sg_c" {
  name        = "app_sg_c"
  description = "The Security Group of the App"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.namespace}-app_sg_c"
    Environemnt = "dev"
  }
}

#################################
###       INGRESS RULES       ###
#################################

######    BASTION SSH    ########

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

######      APP SSH       #######

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

#######    APP HTTP       ######

resource "aws_security_group_rule" "app_http_a" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_a.id
}

resource "aws_security_group_rule" "app_http_b" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_b.id
}

resource "aws_security_group_rule" "app_http_c" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg_c.id
}

###################################
###        EGRESS RULES         ###
###################################

#######    BASTION SSH       ######

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

#######    BASTION PING      ######

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

#######    APP PING      ######

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

#######    APP HTTP       ######

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
