module "key-pair" {
  source = "./ASG/aws_key_pair"
  providers = {
    aws = aws.region-master
  }
  path_to_file = var.path_to_file_key
  key_name     = "ssh_asg_bastion"
}
module "sg_app" {
  source = "./ASG/aws_sg_application"
  vpc_id = module.vpc-app.id_vpc
  providers = {
    aws = aws.region-master
  }
  depends_on = [module.vpc-app]
}
module "lc" {
  source = "./ASG/aws_launch_template"
  providers = {
    aws = aws.region-master
  }
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  application_sg_id = module.sg_app.id
  key_name          = module.key-pair.key_name
}
module "asg_group" {
  source = "./ASG/aws_autoscaling_group"
  providers = {
    aws = aws.region-master
  }
  private_subnet_1_id  = module.subnet_private_1.id
  private_subnet_2_id  = module.subnet_private_2.id
  alb_target_group_arn = module.lb-target-groups.arn
  launch_template_id   = module.lc.id
  depends_on           = [module.subnet_private_1, module.subnet_private_2]
}
module "policy_scale" {
  source = "./ASG/aws_autoscaling_policy"
  providers = {
    aws = aws.region-master
  }
  asg_name          = module.asg_group.asg_name
  target_scale_down = var.target_scale_down
  target_scale_up   = var.target_scale_up
}