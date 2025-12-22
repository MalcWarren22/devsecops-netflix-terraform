# Security Configuration files

locals {
  web_cidr = var.public_web ? ["0.0.0.0/0"] : [var.allowlist_cidr]
}

resource "aws_security_group" "tools" {
  name        = "${var.name}-${var.env}-tools-sg"
  description = "Security group for tools EC2 (Jenkins/Sonar/Grafana/etc)"
  vpc_id      = data.aws_vpc.default.id

  # Jenkins
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = local.web_cidr
  }

  # SonarQube
  ingress {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = local.web_cidr
  }

  # Grafana
  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = local.web_cidr
  }

  # Prometheus
  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = local.web_cidr
  }

  # Netflix app clone (optional — you can remove if you want it private)
  ingress {
    description = "Malcflix app"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = local.web_cidr
  }

  # Egress open (standard)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-${var.env}-tools-sg"
  }
}
