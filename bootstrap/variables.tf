# Variables file for the EC2 Bootstrap

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "state_bucket_name" {
  type        = string
  description = "Global Unique S3 bucket name for TFState"
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table name for Terraform state locking"
}

