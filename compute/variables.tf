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

variable "ami_ssm_param_name" {
  description = "Parameter name of the AWS SSM Parameter for Amazon Machine Image"
  type        = string
  default     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "ecs_ami_from_ssm" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/retrieve-ecs-optimized_AMI.html
  description = "ID of the Optimized AMI for ECS"
  type        = string
  default     = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended"
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

variable "ecs_cluster_name" {
  type        = string
  description = "Name of the ECS Cluster"
}

variable "ecs_profile_name" {
  type        = string
  description = "Name of the IAM ECS Instance Profile"
}

variable "asg_min" {
  type        = number
  description = "Minimum number of instances in Autoscaling Group for ECS"
}

variable "asg_max" {
  type        = number
  description = "Maximum number of instances in Autoscaling Group for ECS"
}

variable "asg_desired" {
  type        = number
  description = "Desired number of instances in Autoscaling Group for ECS"
}

variable "app_sub_a" {
  type = string
}

variable "app_sub_b" {
  type = string
}

variable "app_sub_c" {
  type = string
}
