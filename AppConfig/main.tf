resource "aws_appconfig_application" "ec2_appconfig" {
  name        = "ec2-public-ip-check"
  description = "AppConfig for EC2 public IP check logic"
}

# Tạo AppConfig Environment
resource "aws_appconfig_environment" "production" {
  application_id = aws_appconfig_application.ec2_appconfig.id
  name           = "production"
  description    = "Production environment for EC2 check"
}

# Tạo AppConfig Configuration Profile
resource "aws_appconfig_configuration_profile" "ec2_config_profile" {
  application_id = aws_appconfig_application.ec2_appconfig.id
  name           = "ec2-config-profile"
  description    = "Configuration profile for EC2 public IP check"
  location_uri   = "hosted"
  type           = "AWS.Freeform"
}

# Tạo phiên bản cấu hình trong AppConfig
resource "aws_appconfig_hosted_configuration_version" "ec2_config_version" {
  application_id           = aws_appconfig_application.ec2_appconfig.id
  configuration_profile_id = aws_appconfig_configuration_profile.ec2_config_profile.configuration_profile_id
  content_type             = "application/json"

  content = jsonencode({
    allowed_tags = ["bastion-master"]
  })
}

# Triển khai cấu hình AppConfig
resource "aws_appconfig_deployment" "ec2_config_deployment" {
  application_id           = aws_appconfig_application.ec2_appconfig.id
  configuration_profile_id = aws_appconfig_configuration_profile.ec2_config_profile.configuration_profile_id
  configuration_version    = aws_appconfig_hosted_configuration_version.ec2_config_version.version_number
  environment_id           = aws_appconfig_environment.production.environment_id
  deployment_strategy_id   = "AppConfig.AllAtOnce"
  description              = "Initial deployment for EC2 public IP check"
}