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
module "lambda_function_appconfig" {
    source = "./Lambda/aws_lambda_function_app_config"
    providers = {
        aws = aws.region-master
    }
    lambda_role_arn = module.iamrole-lambda.arn
    name_function = "Appconfig"
    config-application-id = module.Appconfig.config-application-id
    config-environment-id = module.Appconfig.config-environment-id
    config-profile-id = module.Appconfig.config-profile-id
}
module "lambda_permission" {
    source = "./Lambda/aws_lambda_permission"
    providers = {
        aws = aws.region-master
    }
    cloudwatch_event_rule = module.eventbridge.arn_cloudwatch_event_rule
    function_name = module.lambda_function.function_name
    cloudwatch_event_rule_2 = module.eventbridge_appconfig.arn_cloudwatch_event_rule
    function_name_2 = module.lambda_function_appconfig.function_name
}
