variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
}

variable "key_pair_name" {
  description = "Key Name for SSH"
  type        = string
  default     = "my_key_pair"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
  type        = string
}

variable "ami" {
  description = "Name of the AWS SSM Parameter for Amazon Machine Image"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "pub_a_id" {
  description = "The ID of the Public Subnet A"
}

variable "pub_b_id" {
  description = "The ID of the Public Subnet A"
}

variable "pub_c_id" {
  description = "The ID of the Public Subnet A"
}

variable "priv_a_id" {
  description = "The ID of the Subnet of App A"
}

variable "priv_b_id" {
  description = "The ID of the Subnet of App B"
}

variable "priv_c_id" {
  description = "The ID of the Subnet of App C"
}

variable "bastion_sg_a" {
  type = string
}

variable "bastion_sg_b" {
  type = string
}

variable "bastion_sg_c" {
  type = string
}

variable "app_sg_a" {
  type = string
}

variable "app_sg_b" {
  type = string
}

variable "app_sg_c" {
  type = string
}
