resource "aws_cloudwatch_event_rule" "codebuild_failure" {
  name        = var.eventbridge_name
  description = "Triggers when a Codepipeline fails"

  event_pattern = jsonencode({
    source      = ["aws.codepipeline"],
    "detail-type" = ["Codepipeline State Change"],
    detail = {
      "build-status" = ["FAILED"]
    }
  })
}
resource "aws_cloudwatch_event_target" "invoke_lambda" {
  rule      = aws_cloudwatch_event_rule.codebuild_failure.name
  target_id = "InvokeLambda"
  arn       = var.lambda_arn
}