#Backend file for Terraform

#Backend file for Terraform

terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = "devsecops-netflix-dev-tfstate-tfs3"
    key            = "foundation/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "devsecops-netflix-dev-tflock"
    encrypt        = true
  }
}
