# Terraform Main file for tools-ec2 stack

resource "aws_instance" "tools" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  iam_instance_profile   = aws_iam_instance_profile.tools.name
  vpc_security_group_ids = [aws_security_group.tools.id]
  subnet_id = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true


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
