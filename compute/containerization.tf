resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "ecs_task" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html
  family                   = var.ecs_task_name
  container_definitions    = file("${path.module}/container_definitions.json")
  requires_compatibilities = ["EC2"]

}

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_definition_parameters.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
resource "aws_ecs_service" "ecs_service" {
  name                = var.ecs_service_name
  # iam_role            = var.ecs_service_role_name
  cluster             = aws_ecs_cluster.ecs_cluster.id
  task_definition     = aws_ecs_task_definition.ecs_task.family
  launch_type         = "EC2"     # default
  scheduling_strategy = "REPLICA" # default
  desired_count       = 1         # required if REPLICA
  deployment_controller {
    type = "ECS" # default
  }
}
