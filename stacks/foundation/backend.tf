#Backend file for Terraform

terraform {
  backend "s3" {
    bucket         = "devsecops-netflix-dev-tfstate-tfs3"
    key            = "foundation/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "devsecops-netflix-dev-tflock"
    encrypt        = true
  }
}