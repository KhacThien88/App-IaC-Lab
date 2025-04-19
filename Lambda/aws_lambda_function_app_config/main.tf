data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_function_handle"
  output_path = "${path.module}/lambda_function_handle/lambda_function.zip"
}
resource "aws_lambda_function" "ec2_public_ip_check" {
  filename      = "${path.module}/lambda_function_handle/lambda_function.zip"
  function_name = var.name_function
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  environment {
    variables = {
      APPCONFIG_APPLICATION_ID = var.config-application-id
      APPCONFIG_ENVIRONMENT_ID = var.config-environment-id
      APPCONFIG_PROFILE_ID     = var.config-profile-id
    }
  }
}