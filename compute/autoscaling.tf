data "aws_ssm_parameter" "ecs_ami" {
  name = var.ecs_ami_from_ssm
}

resource "aws_launch_template" "ecs_launch_temp" {
  name_prefix   = var.namespace
  image_id      = jsondecode(data.aws_ssm_parameter.ecs_ami.value)["image_id"]
  instance_type = var.instance_type
  iam_instance_profile {
    name = var.ecs_profile_name
  }
  vpc_security_group_ids = [
    var.app_sg_a_id,
    var.app_sg_b_id,
    var.app_sg_c_id
  ]
  key_name               = aws_key_pair.key_pair.key_name
  user_data              = base64encode(
                           <<EOF
                           #!/bin/bash
                           echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
                           EOF
                          )
}

resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix         = var.namespace
  max_size            = var.asg_max
  min_size            = var.asg_min
  desired_capacity    = var.asg_desired
  vpc_zone_identifier = [
    var.priv_a_id, var.priv_b_id, var.priv_c_id
  ]
  launch_template {
    id = aws_launch_template.ecs_launch_temp.id
  }
}
