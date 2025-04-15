module "sns"{
    source = "./SNS/aws_sns_topic"
    providers = {
        aws = aws.region-master
    }
    name_topic = var.topic_sns_codepipeline_failed
    
}