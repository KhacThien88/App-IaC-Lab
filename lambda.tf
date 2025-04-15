module "iamrole-lambda" {
    source = "./Lambda/aws_iam_role"
    providers = {
        aws = aws.region-master
    }
    sns_topic_arn = module.sns.arn
}
module "lambda_function" {
    source = "./Lambda/aws_lambda_function"
    providers = {
        aws = aws.region-master
    }
    sns_topic_arn = module.sns.arn
    name_function = var.name_function
    lambda_role_arn = module.iamrole-lambda.arn
}
module "lambda_permission" {
    source = "./Lambda/aws_lambda_permission"
    providers = {
        aws = aws.region-master
    }
    cloudwatch_event_rule = module.eventbridge.arn_cloudwatch_event_rule
    function_name = module.lambda_function.function_name
}