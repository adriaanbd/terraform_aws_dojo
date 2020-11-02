# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "ecs_policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/instance_IAM_role.html
data "aws_iam_policy_document" "ecs_instance_policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_role" {
  name                = var.ecs_service_role_name
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.ecs_policy.json
}

resource "aws_iam_role" "ecs_instance_role" {
    name                = var.ecs_instance_role_name
    path                = "/"
    assume_role_policy  = data.aws_iam_policy_document.ecs_instance_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_role_attchmnt" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = var.arn_iam_ec2_ecs_service_policy
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attchmnt" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = var.arn_iam_ec2_ecs_service_policy
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = var.ecs_instance_profile_name
  role = aws_iam_role.ecs_instance_role.name
}