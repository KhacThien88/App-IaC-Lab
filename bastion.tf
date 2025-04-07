module "sg_bastion" {
  source = "./Bastion/aws_security_group"
  providers = {
    aws = aws.region-master
  }
  vpc_id = module.vpc-app.id_vpc
}
module "bastion_host" {
  source = "./Bastion/aws_instance"
  providers = {
    aws = aws.region-master
  }
  ami                   = var.ami_id
  instance-type         = var.instance-type-master
  key_name              = module.key-pair.key_name
  subnet_id_1           = module.subnet_public_1.id
  sg_id                 = module.sg_bastion.id
  tag                   = "bastion-master"
  depends_on            = [module.subnet_public_1, module.sg_bastion]
  ansible_playbook_path = "./ansible_templates/install_plugins.yaml"
  region                = var.region-master
  profile               = var.profile
}