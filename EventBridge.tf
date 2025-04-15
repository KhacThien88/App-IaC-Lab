module "eventbridge" {
    source = "./EventBridge/aws_cloudwatch_event"
    providers = {
        aws = aws.region-master
    }
    eventbridge_name = var.eventbridge_name
    lambda_arn = module.lambda_function.arn
}