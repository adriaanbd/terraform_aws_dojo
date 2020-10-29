variable "vpc_cidr" {
  description = "The CIDR block for VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
}
