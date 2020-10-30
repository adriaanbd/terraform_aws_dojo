variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
}

variable "vpc_id" {
    type = string
    description = "ID of the Main VPC"
}
