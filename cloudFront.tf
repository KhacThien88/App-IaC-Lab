module "cloudFront" {
  source = "./CloudFront"
  providers = {
    aws = aws.us-east-1
  }
  wafcloudfront-arn = module.waf-cloudfront.arn
}