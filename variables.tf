# Input Variables
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-2"
}

## Create Variable for S3 Bucket Name
variable "my_s3_name" {
  description = "S3 Bucket name that we pass to S3 Custom Module"
  type = string
  default = "terraform-mm-devops-cloud"
}

## Create Variable for S3 Bucket Tags
variable "my_s3_tags" {
  description = "Tags to set on the bucket"
  type = map(string)
  default = {
    Terraform = "True"
    Name = "dev"
  }
}