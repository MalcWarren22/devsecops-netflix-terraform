# DefaultVPC due to no IP

data "aws_vpc" "default" {
  default = true
}
