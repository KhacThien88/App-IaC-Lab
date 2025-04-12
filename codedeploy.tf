module "iamrole-codedeploy" {
  source = "./CodeDeploy/aws_iam_role"
  providers = {
    aws = aws.region-master
  }
}
module "codedeploy" {
  source = "./CodeDeploy/aws_codedeploy"
  providers = {
    aws = aws.region-master
  }
  codedeploy_role_arn = module.iamrole-codedeploy.arn
  asg_name = module.asg_group.asg_name
  id_code_build = module.codebuild.id
  s3_bucket = module.s3-todo-cb-cd.bucket
  deployment_group_name = var.deployment_group_name
}