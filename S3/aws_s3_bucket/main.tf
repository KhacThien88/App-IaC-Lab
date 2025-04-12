resource "aws_s3_bucket" "build_artifacts" {
  bucket = var.bucket-name
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.build_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}
