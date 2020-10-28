variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
  type        = string
}

variable "az" {
  description = "AWS Availability Zone"
  default     = "us-east-1a"
  type        = string
}

variable "ami" {
  description = "Name of the AWS SSM Parameter for Amazon Machine Image"
  type        = string
  # Amazon Linux 2 AMI (HVM) - Free Tier
  default     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "vpc_cidr" {
  description = "The CIDR block for VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "pub_sub_a_cidr" {
  description = "The CIDR block for Public Subnet"
  type        = string
  default     = "172.16.1.0/24"
}

variable "pub_sub_b_cidr" {
  description = "The CIDR block for Public Subnet"
  type        = string
  default     = "172.16.2.0/24"
}

variable "pub_sub_c_cidr" {
  description = "The CIDR block for Public Subnet"
  type        = string
  default     = "172.16.3.0/24"
}

variable "priv_sub_a_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.4.0/24"
}

variable "priv_sub_b_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.5.0/24"
}

variable "priv_sub_c_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.6.0/24"
}

variable "key_name" {
  description = "Key Name for SSH"
  type        = string
}

variable "key_path" {
  description = "Key path for SSH"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
  type        = string
}
