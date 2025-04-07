terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # backend "s3" {
  #   region  = "ap-southeast-1"
  #   profile = "default"
  #   key     = "terraformstatelab01file"
  #   bucket  = "terraformstatebackendlab01-iac"
  # }
}


