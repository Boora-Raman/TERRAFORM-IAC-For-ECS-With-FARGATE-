terraform {
  backend "s3" {
    bucket         = "medusa-terraform-state-bucket-777"
    key            = "terraform/medusa/dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "medusa-terraform-lock"
  }
}
