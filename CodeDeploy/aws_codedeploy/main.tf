resource "aws_codedeploy_app" "app_deploy" {
  name = "app-deploy-application"
}
resource "aws_codedeploy_deployment_group" "app_dg" {
  app_name              = aws_codedeploy_app.app_deploy.name
  deployment_group_name = var.deployment_group_name
  service_role_arn      = var.codedeploy_role_arn

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  autoscaling_groups = [var.asg_name]

  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "codedeploy-instance"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
