module "iamrole-codebuild" {  
  source = "./CodeBuild/aws_iam_role"
  providers = {
    aws = aws.region-master
  }
}
module "codebuild" {
  source = "./CodeBuild/aws_codebuild_project"
  providers = {
    aws = aws.region-master
  }
  codebuild_role_arn = module.iamrole-codebuild.arn
  s3_bucket = module.s3-todo-cb-cd.bucket
}