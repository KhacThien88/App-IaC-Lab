output "arn" {
  value = aws_lambda_function.ec2_public_ip_check.arn
}
output "function_name" {
  value = aws_lambda_function.ec2_public_ip_check.function_name
}