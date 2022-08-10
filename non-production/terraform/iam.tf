data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::895470510842:role/atlantis-ecs_task_execution",
        "arn:aws:iam::895470510842:role/aws-reserved/sso.amazonaws.com/eu-west-1/AWSReservedSSO_humn-core-devops_5a4c6297725915f9"
      ]
    }
  }
}

resource "aws_iam_role" "terragrunt" {
  name                  = "humn-terragrunt-role"
  path                  = "/"
  max_session_duration  = 3600
  description           = "IAM role for atlantis managing TF resources"
  force_detach_policies = false
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  tags = {
    Description = "Managed by AFT account customization"
    Name        = "humn-terragrunt-role"
    Namespace   = "humnai"
  }
}

resource "aws_iam_role_policy_attachment" "existing_policies" {
  role       = aws_iam_role.terragrunt.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}