resource "aws_sns_topic" "build_failure" {
  name = var.name_topic
}

resource "aws_sns_topic_subscription" "user_subscription" {
  topic_arn = aws_sns_topic.build_failure.arn
  protocol  = "email"
  endpoint  = "KTeightop1512@gmail.com"
}