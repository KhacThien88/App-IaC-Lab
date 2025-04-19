resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_event_rule
}
resource "aws_lambda_permission" "allow_eventbridge_appconfig" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name_2
  principal     = "events.amazonaws.com"
  source_arn    = var.cloudwatch_event_rule_2
}
