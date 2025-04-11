resource "aws_codebuild_project" "app_build" {
  name          = "taskapp-be"
  description   = "Build application for deployment"
  service_role  = var.codebuild_role_arn

  artifacts {
    type           = "S3"
    location       = var.s3_bucket
    name           = "build-output"
    packaging      = "ZIP"
    path           = "artifacts"
    namespace_type = "BUILD_ID"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/KhacThien88/CloudHCMUS_IaC_Lab01"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
}
