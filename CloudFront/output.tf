output "cloudfront_domain" {
  value = aws_cloudfront_distribution.taskapp_distribution.domain_name
}
output "arn" {
  value = aws_cloudfront_distribution.taskapp_distribution.arn
}