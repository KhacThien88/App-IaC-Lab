output "config-application-id" {
  value = aws_appconfig_application.ec2_appconfig.id
}
output "config-environment-id" {
  value = aws_appconfig_environment.production.id
}
output "config-profile-id" {
  value = aws_appconfig_configuration_profile.ec2_config_profile.id
}