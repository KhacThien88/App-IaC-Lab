module "iamrole-codepipeline" {
  source = "./CodePipeline/aws_iam_role"
  providers = {
    aws = aws.region-master
  }
}

module "codepipeline" {
  source = "./CodePipeline/aws_codepipeline"
  providers = {
    aws = aws.region-master
  }
  id_code_build = module.codebuild.id
  s3_bucket = module.s3-todo-cb-cd.bucket
  id_code_pipeline_arn = module.iamrole-codepipeline.arn
  code_deploy_app_name = module.codedeploy.name_cd_app
  code_deployment_group_name = var.deployment_group_name
}