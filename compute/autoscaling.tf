data "aws_ssm_parameter" "ecs_ami" {
  name = var.ecs_ami_from_ssm
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration
resource "aws_launch_configuration" "ecs_launch_temp" {
  name_prefix             = "lt-${var.namespace}-"
  image_id                = jsondecode(data.aws_ssm_parameter.ecs_ami.value)["image_id"]
  instance_type           = var.instance_type
  iam_instance_profile    = var.ecs_profile_arn

  lifecycle {
    create_before_destroy = true
  }

  security_groups       = [var.app_sg_a_id, var.app_sg_b_id, var.app_sg_c_id]
  key_name              = aws_key_pair.key_pair.key_name
  user_data_base64      = base64encode(
                          <<EOF
                          #!/bin/bash
                          echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config && \
                          echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config
                          EOF
                        )
  enable_monitoring     = true  # enabled by default
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true        # default
    encrypted             = false       # default
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix           = var.namespace
  max_size              = var.asg_max
  min_size              = var.asg_min
  desired_capacity      = var.asg_desired
  vpc_zone_identifier   = [var.priv_a_id, var.priv_b_id, var.priv_c_id]
  launch_configuration  = aws_launch_configuration.ecs_launch_temp.name
}
