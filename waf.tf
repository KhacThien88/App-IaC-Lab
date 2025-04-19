module "waf-alb"{
    source = "./WAF/aws_wafv2_web_acl_ALB"
    providers = {
        aws = aws.region-master
    }
    alb-arn = module.lb.arn
}
module "waf-cloudfront"{
    source = "./WAF/aws_wafv2_web_acl_cloudFront"
    providers = {
        aws = aws.region-master
    }
}