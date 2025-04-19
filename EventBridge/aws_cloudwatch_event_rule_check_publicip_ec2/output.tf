output "arn_cloudwatch_event_rule" {
  value = aws_cloudwatch_event_rule.ec2_state_change.arn
}