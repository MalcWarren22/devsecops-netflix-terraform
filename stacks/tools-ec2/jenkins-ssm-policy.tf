# Jenkins SSM Policy

resource "aws_iam_policy" "jenkins_ssm_deploy" {
  name        = "${var.name}-${var.env}-jenkins-ssm-deploy"
  description = "Allow Jenkins (tools EC2 role) to deploy to app EC2 via SSM Run Command"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:ListCommandInvocations"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances"
        ]
        Resource = "*"
      }
    ]
  })
}
