# module "s3-static-website" {
#   source  = "mm-devops-cloud/s3-static-website/aws"
#   version = "1.0.1"
# }

module "s3-static-website" {
  source  = "git@github.com:mm-devops-cloud/terraform-aws-s3-static-website.git"
}

