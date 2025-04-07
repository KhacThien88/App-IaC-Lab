module "db_secret" {
  source = "./SecretManager"
  providers = {
    aws = aws.region-master
  }
  mysql_host     = module.db_rds.address
  mysql_password = var.db_password
  mysql_username = var.db_username
  name_secret    = var.name_secret
  db_name        = var.db_name
  depends_on     = [module.db_rds]
}