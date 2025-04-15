data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_function_handle"
  output_path = "${path.module}/lambda_function_handle/lambda_function.zip"
}
resource "aws_lambda_function" "diagnose_code" {
  filename      = "${path.module}/lambda_function_handle/lambda_function.zip"
  function_name = var.name_function
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  environment {
    variables = {
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }

  depends_on = [
    data.archive_file.lambda_zip
  ]
}