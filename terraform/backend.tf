terraform {
  backend "s3" {
    bucket         = "dyninno-remote-backend-bucket"
    key            = "dyninno/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "dyninno-terraform-locks"
  }
}
