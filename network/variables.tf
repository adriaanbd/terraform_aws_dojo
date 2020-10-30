variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
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

variable "priv_sub_app_a_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.4.0/24"
}

variable "priv_sub_app_b_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.5.0/24"
}

variable "priv_sub_app_c_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.6.0/24"
}

variable "priv_sub_ddbb_a_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.7.0/24"
}

variable "priv_sub_ddbb_b_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.8.0/24"
}

variable "priv_sub_ddbb_c_cidr" {
  description = "The CIDR block for Private Subnet"
  type        = string
  default     = "172.16.9.0/24"
}

variable "az_a" {
  description = "AWS Availability Zone"
  default     = "us-east-1a"
  type        = string
}

variable "az_b" {
  description = "AWS Availability Zone"
  default     = "us-east-1b"
  type        = string
}

variable "az_c" {
  description = "AWS Availability Zone"
  default     = "us-east-1c"
  type        = string
}
