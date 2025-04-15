output "arn_cloudwatch_event_rule" {
  value = aws_cloudwatch_event_rule.codebuild_failure.arn
}