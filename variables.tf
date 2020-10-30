variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
  type        = string
}

variable "key_pair_name" {
  description = "Key Name for SSH"
  type        = string
  default     = "my_key_pair"
}