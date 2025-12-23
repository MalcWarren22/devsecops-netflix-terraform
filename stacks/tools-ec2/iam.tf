# IAM for EC2

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "tools_ssm" {
  name               = "${var.name}-${var.env}-tools-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# AWS-managed policy that enables SSM Session Manager
resource "aws_iam_role_policy_attachment" "tools_ssm_core" {
  role       = aws_iam_role.tools_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "tools" {
  name = "${var.name}-${var.env}-tools-instance-profile"
  role = aws_iam_role.tools_ssm.name
}

# EC2 allowed to assume deploy role

data "aws_iam_policy_document" "jenkins_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.tools_ssm.arn] # EC2 Instance Role

    }
  }
}

resource "aws_iam_role" "jenkins_deploy" {
  name               = "${var.name}-${var.env}-jenkins-deploy-role"
  assume_role_policy = data.aws_iam_policy_document.jenkins_assume_role.json
}

resource "aws_iam_role_policy_attachment" "jenkins_deploy_admin" {
  role       = aws_iam_role.jenkins_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Change to poweruser after testing
}

resource "aws_iam_role_policy_attachment" "tools_ssm_deploy" {
  role       = aws_iam_role.tools_ssm.name
  policy_arn = aws_iam_policy.jenkins_ssm_deploy.arn
}
