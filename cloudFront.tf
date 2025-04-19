module "cloudFront" {
  source = "./CloudFront"
  providers = {
    aws = aws.region-master
  }
  wafcloudfront-arn = module.waf-cloudfront.arn
}