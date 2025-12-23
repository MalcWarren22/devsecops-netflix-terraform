# Variables file for the tools-ec2 folder
variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "name" {
  type        = string
  description = "Project name prefix"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "allowlist_cidr" {
  type        = string
  description = "CIDR allowed to access web UIs"
  default     = "0.0.0.0/0"
}

variable "public_web" {
  type        = bool
  description = "If true, allow web ports from 0.0.0.0/0 (NOT recommended)"
  default     = false
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "aws_vpc" {
  type        = string
  description = "AWS VPC ID"
}