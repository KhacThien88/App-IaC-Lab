output "bucket" {
  value = aws_s3_bucket.build_artifacts.bucket
}
output "arn" {
  value = aws_s3_bucket.build_artifacts.arn
}