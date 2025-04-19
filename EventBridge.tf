module "eventbridge" {
    source = "./EventBridge/aws_cloudwatch_event"
    providers = {
        aws = aws.region-master
    }
    eventbridge_name = var.eventbridge_name
    lambda_arn = module.lambda_function.arn
}
module "eventbridge_appconfig" {
    source = "./EventBridge/aws_cloudwatch_event_rule_check_publicip_ec2"
    providers = {
        aws = aws.region-master
    }
    lanmbda-function-arn = module.lambda_function_appconfig.arn
}