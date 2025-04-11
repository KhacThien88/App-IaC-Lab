output "name_cd_app" {
  value = aws_codedeploy_app.app_deploy.name
}
output "name_cd_deployment_group" {
  value = aws_codedeploy_deployment_group.app_dg.app_name
}