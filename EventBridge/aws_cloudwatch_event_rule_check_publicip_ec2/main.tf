resource "aws_cloudwatch_event_rule" "ec2_state_change" {
  name        = "ec2-state-change-trigger"
  description = "Trigger Lambda on EC2 state change"

  event_pattern = jsonencode({
    source = ["aws.ec2"]
    detail-type = ["EC2 Instance State-change Notification"]
    detail = {
      state = ["running", "pending"]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "ec2-public-ip-check"
  arn       = var.lanmbda-function-arn
}

