resource "aws_codebuild_project" "app_build" {
  name          = "build-output"
  description   = "Build application for deployment"
  service_role  = var.codebuild_role_arn

  artifacts {
    type           = "S3"
    location       = var.s3_bucket
    name           = "build-output"
    packaging      = "ZIP"
    path           = "artifacts"
    namespace_type = "NONE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    environment_variable {
      name  = "AWS_ACCESS_KEY_ID"
      type  = "SECRETS_MANAGER"
      value = "${var.credential_login_secret_arn}:AWS_ACCESS_KEY_ID"
    }

    environment_variable {
      name  = "AWS_SECRET_ACCESS_KEY"
      type  = "SECRETS_MANAGER"
      value = "${var.credential_login_secret_arn}:AWS_SECRET_ACCESS_KEY"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/KhacThien88/CloudHCMUS_Lab01_BE"
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
}
