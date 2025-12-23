# EC2 Instance for the "Netflix App"

resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true

  iam_instance_profile   = aws_iam_instance_profile.tools.name
  vpc_security_group_ids = [aws_security_group.app.id]

  tags = {
    Name = "${var.name}-${var.env}-app-ec2"
    Role = "app"
  }
}

output "app_instance_id" {
  value = aws_instance.app.id
}

output "app_public_ip" {
  value = aws_instance.app.public_ip
}

output "app_url" {
  value = "http://${aws_instance.app.public_ip}:8081"
}
