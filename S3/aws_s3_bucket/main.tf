resource "aws_s3_bucket" "build_artifacts" {
  bucket = var.bucket-name
  force_destroy = true
}
