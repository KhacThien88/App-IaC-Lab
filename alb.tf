module "sg-lb" {
  source = "./ALB/aws_security_group_lb"
  providers = {
    aws = aws.region-master
  }
  vpc_master_id = module.vpc-app.id_vpc

}
module "lb" {
  source = "./ALB/aws_lb"
  providers = {
    aws = aws.region-master
  }
  lb-sg-id           = module.sg-lb.id
  public_subnet_1_id = module.subnet_public_1.id
  public_subnet_2_id = module.subnet_public_2.id
}
module "lb-target-groups" {
  source = "./ALB/aws_lb_target_group"
  providers = {
    aws = aws.region-master
  }
  vpc_master_id = module.vpc-app.id_vpc
}
module "lb-listener" {
  source = "./ALB/aws_lb_listener"
  providers = {
    aws = aws.region-master
  }
  alb-arn              = module.lb.arn
  alb-target-group-arn = module.lb-target-groups.arn
  acm-arn              = module.route53-acm.arn
}