provider "aws" {
  profile = var.profile
  region  = var.region-master
  alias   = "region-master"
}
provider "aws" {
  profile = var.profile
  region  = "us-east-1"
  alias   = "us-east-1"
}