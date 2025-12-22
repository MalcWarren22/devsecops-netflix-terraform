# VPC networking file

# Uses the AWS default VPC
data "aws_vpc" "default" {
  default = true
}

# Gets all subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
