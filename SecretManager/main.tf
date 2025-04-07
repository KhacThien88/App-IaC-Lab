resource "aws_secretsmanager_secret" "db_secret" {
  name = var.name_secret
  description = "MySQL database credentials"

  tags = {
    Name = "mysql-db-secret"
  }
}
resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    host     = var.mysql_host
    port     = "3306"
    username = var.mysql_username
    db_name  = var.db_name
    password = var.mysql_password
  })
}
