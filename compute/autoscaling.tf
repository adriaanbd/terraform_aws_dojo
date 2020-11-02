data "aws_ssm_parameter" "ecs_ami_id" {
  name = var.ecs_ami_from_ssm
}

resource "aws_launch_template" "ecs_launch_temp" {
  name_prefix   = var.namespace
  image_id      = data.ecs_ami_from_ssm
  instance_type = var.instance_type
  iam_instance_profile {
    name = var.ecs_instance_profile_name
  }
  vpc_security_group_ids = [priv_a_id, priv_b_id, priv_c_id]
  key_name               = var.key_pair_name
  user_data              = <<EOF
                           #!/bin/bash
                           echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
                           EOF
}

resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix         = var.namespace
  max_size            = var.asg_max
  min_size            = var.asg_min
  desired_capacity    = var.asg_desired
  vpc_zone_identifier = [var.app_sub_a, var.app_sub_b, var.app_sub_c]

  launch_template {
    id = aws_launch_template.ecs_launch_temp.id
  }
  tags {
    environment = "dev"
    project     = var.namespace
  }
}
