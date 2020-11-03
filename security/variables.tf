variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
}

variable "vpc_id" {
    type        = string
    description = "ID of the Main VPC"
}

# variable "ecs_service_role_name" {
#   type          = string
#   description   = "Given name of the ECS service role"
#   default       = "ecs-service-role"
# }

variable "ecs_instance_role_name" {
  type          = string
  description   = "Given name of the ECS instance role"
  default       = "ecs-instance-role"
}

variable "ecs_instance_profile_name" {
  type          = string
  description   = "Given name of the ECS instance profile"
  default       = "ecs-instance-profile"
}


variable "arn_iam_ec2_ecs_service_policy" {
  type          = string
  description   = "AWS ARN for the ECS "
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html
  default       = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
