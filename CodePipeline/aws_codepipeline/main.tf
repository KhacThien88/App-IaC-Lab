resource "aws_codepipeline" "app_pipeline" {
  name     = "app-deploy-pipeline"
  role_arn = var.id_code_pipeline_arn
  artifact_store {
    location = var.s3_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        S3Bucket = var.s3_bucket
        S3ObjectKey = "artifacts/build-output.zip"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name             = "CodeDeploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeDeploy"
      input_artifacts  = ["source_output"]
      version          = "1"

      configuration = {
        ApplicationName     = var.code_deploy_app_name
        DeploymentGroupName = var.code_deployment_group_name
      }
    }
  }
}