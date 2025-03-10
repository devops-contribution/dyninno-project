terraform {
  backend "s3" {
    bucket         = "kind-remote-backend-bucket"
    key            = "kind-cluster/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "kind-terraform-locks"
  }
}
