module "guardduty" {
  source = "./GuardDuty"
  providers = {
    aws = aws.region-master
  }
}