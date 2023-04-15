terraform {
  backend "s3" {
    bucket = "terraform-demo"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
