module "cloudFront" {
  source = "./CloudFront"
  providers = {
    aws = "us-east-1"
  }
  wafcloudfront-arn = module.waf-cloudfront.arn
}