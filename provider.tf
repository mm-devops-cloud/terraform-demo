# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "4.62.0"
#     }
#   }
# }

# provider "aws" {
#   region  = "us-east-2"
#   profile = "mohamed"
# }

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}


provider "docker" {
  # Configuration options
  host = "npipe:////./pipe/docker_engine"
}
provider "local" {
  # Configuration options
}