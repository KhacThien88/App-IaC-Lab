//Create VPC
module "vpc-app" {
  source = "./Networking/aws_vpc"
  providers = {
    aws = aws.region-master
  }
  cidr_block_vpc = var.cidr_block_master_vpc
  tag            = "lab01-vpc"
}
//Create IGW
module "igw" {
  source = "./Networking/aws_internet_gateway"
  providers = {
    aws = aws.region-master
  }
  id_vpc = module.vpc-app.id_vpc
  tag    = "igw-vpc-lab01"
}
//Get AZ
module "region-az" {
  source = "./Networking/aws_availability_zones"
  providers = {
    aws = aws.region-master
  }
}
//Create subnet
module "subnet_public_1" {
  source = "./Networking/aws_subnet"
  providers = {
    aws = aws.region-master
  }
  cidr_block_subnet = var.cidr_block_public_subnet_1
  vpc_id            = module.vpc-app.id_vpc
  az                = element(module.region-az.names, 0)
  tag               = "public-subnet-az-1"
}
module "subnet_public_2" {
  source = "./Networking/aws_subnet"
  providers = {
    aws = aws.region-master
  }
  cidr_block_subnet = var.cidr_block_public_subnet_2
  vpc_id            = module.vpc-app.id_vpc
  az                = element(module.region-az.names, 1)
  tag               = "public-subnet-az-2"
}
module "subnet_private_1" {
  source = "./Networking/aws_subnet"
  providers = {
    aws = aws.region-master
  }
  cidr_block_subnet = var.cidr_block_private_subnet_1
  vpc_id            = module.vpc-app.id_vpc
  az                = element(module.region-az.names, 0)
  tag               = "private-subnet-az-1"
}
module "subnet_private_2" {
  source = "./Networking/aws_subnet"
  providers = {
    aws = aws.region-master
  }
  cidr_block_subnet = var.cidr_block_private_subnet_2
  vpc_id            = module.vpc-app.id_vpc
  az                = element(module.region-az.names, 1)
  tag               = "private-subnet-az-2"
}
module "subnet_private_3" {
  source = "./Networking/aws_subnet"
  providers = {
    aws = aws.region-master
  }
  cidr_block_subnet = var.cidr_block_private_subnet_3
  vpc_id            = module.vpc-app.id_vpc
  az                = element(module.region-az.names, 0)
  tag               = "private-subnet-az-1"
}
module "subnet_private_4" {
  source = "./Networking/aws_subnet"
  providers = {
    aws = aws.region-master
  }
  cidr_block_subnet = var.cidr_block_private_subnet_4
  vpc_id            = module.vpc-app.id_vpc
  az                = element(module.region-az.names, 1)
  tag               = "private-subnet-az-2"
}
//Create elasticIP 
module "eip_ngw_1" {
  source = "./Networking/aws_eip"
  providers = {
    aws = aws.region-master
  }
  tag_eip = "eip_ngw_1"
}
module "eip_ngw_2" {
  source = "./Networking/aws_eip"
  providers = {
    aws = aws.region-master
  }
  tag_eip = "eip_ngw_2"
}
//Create Nat-gateway
module "natgw_az_1" {
  source = "./Networking/aws_nat_gateway"
  providers = {
    aws = aws.region-master
  }
  eip_id     = module.eip_ngw_1.eip_id
  subnet_id  = module.subnet_public_1.id
  tag_ngw    = "ngw_az_1"
  depends_on = [module.igw, module.eip_ngw_1]
}
module "natgw_az_2" {
  source = "./Networking/aws_nat_gateway"
  providers = {
    aws = aws.region-master
  }
  eip_id     = module.eip_ngw_2.eip_id
  subnet_id  = module.subnet_public_2.id
  tag_ngw    = "ngw_az_2"
  depends_on = [module.igw, module.eip_ngw_2]
}
//Create route table
module "route-table-public" {
  source = "./Networking/aws_route_table_public"
  providers = {
    aws = aws.region-master
  }
  vpc_id = module.vpc-app.id_vpc
  igw-id = module.igw.id_igw
  tag    = "Routetable-public"
}
module "route-table-natgateway-1" {
  source = "./Networking/aws_route_table_private"
  providers = {
    aws = aws.region-master
  }
  ngw_id      = module.natgw_az_1.nat_gw_id
  vpc_id      = module.vpc-app.id_vpc
  tag_rtb_ngw = "routetable-ngw-1"
}
module "route-table-natgateway-2" {
  source = "./Networking/aws_route_table_private"
  providers = {
    aws = aws.region-master
  }
  ngw_id      = module.natgw_az_2.nat_gw_id
  vpc_id      = module.vpc-app.id_vpc
  tag_rtb_ngw = "routetable-ngw-2"
}
//Associate route table with VPC
module "rtb-associate-public-1" {
  source = "./Networking/aws_route_table_association"
  providers = {
    aws = aws.region-master
  }
  subnet_id      = module.subnet_public_1.id
  route_table_id = module.route-table-public.id
}
module "rtb-associate-public-2" {
  source = "./Networking/aws_route_table_association"
  providers = {
    aws = aws.region-master
  }
  subnet_id      = module.subnet_public_2.id
  route_table_id = module.route-table-public.id
}
module "rtb-associate-private-1" {
  source = "./Networking/aws_route_table_association"
  providers = {
    aws = aws.region-master
  }
  subnet_id      = module.subnet_private_1.id
  route_table_id = module.route-table-natgateway-1.id
}
module "rtb-associate-private-2" {
  source = "./Networking/aws_route_table_association"
  providers = {
    aws = aws.region-master
  }
  subnet_id      = module.subnet_private_2.id
  route_table_id = module.route-table-natgateway-1.id
}


