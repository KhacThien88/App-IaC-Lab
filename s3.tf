module "iamrole-s3" {
  source = "./S3/aws_iam_role"
  providers = {
    aws = aws.region-master
  }
  s3_bucket_arn = module.s3-todo-cb-cd.arn
  codebuild_id = module.codebuild.id
}
module "s3-todo-cb-cd" {
  source = "./S3/aws_s3_bucket"
  providers = {
    aws = aws.region-master
  }
  bucket-name = "taskapp-cb-cd-cp"
}