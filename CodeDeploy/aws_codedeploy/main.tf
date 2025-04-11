resource "aws_codedeploy_app" "app_deploy" {
  name = "app-deploy-application"
}
resource "aws_codedeploy_deployment_group" "app_dg" {
  app_name              = aws_codedeploy_app.app_deploy.name
  deployment_group_name = "app-deployment-group"
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
resource "aws_codedeploy_deployment" "deploy-todo-app" {
  deployment_group_name = aws_codedeploy_deployment_group.app_dg.deployment_group_name
  revision {
    location {
      type   = "S3"
      bucket = var.s3_bucket
      key    = "artifacts/build-output-${var.id_code_build}.zip"
    }
  }
}