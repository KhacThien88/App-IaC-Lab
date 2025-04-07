module "db_subnet_group" {
  source = "./Database/aws_db_subnet_group"
  providers = {
    aws = aws.region-master
  }
  private_subnet_1_id = module.subnet_private_3.id
  private_subnet_2_id = module.subnet_private_4.id
}
module "sg-db-rds" {
  source = "./Database/aws_security_group_rds"
  providers = {
    aws = aws.region-master
  }
  vpc_master_id               = module.vpc-app.id_vpc
  cidr_block_private_subnet_1 = var.cidr_block_private_subnet_1
  cidr_block_private_subnet_2 = var.cidr_block_private_subnet_2
}
module "db_rds" {
  source = "./Database/aws_db_instance"
  providers = {
    aws = aws.region-master
  }
  username             = var.db_username
  db_subnet_group_name = module.db_subnet_group.name
  db_name              = var.db_name
  password             = var.db_password
  sg_db_rds_id         = module.sg-db-rds.id
}