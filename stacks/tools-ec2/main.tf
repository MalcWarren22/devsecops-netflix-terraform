# Terraform Main file for tools-ec2 stack

data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "tools" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.tools.name
  vpc_security_group_ids = [aws_security_group.tools.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "${var.name}-${var.env}-tools-ec2"
  }
}

output "tools_public_ip" {
  value = aws_instance.tools.public_ip
}

output "jenkins_url" {
  value = "http://${aws_instance.tools.public_ip}:8080"
}

output "sonarqube_url" {
  value = "http://${aws_instance.tools.public_ip}:9000"
}
