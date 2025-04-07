resource "aws_db_subnet_group" "main" {
  name       = "mysql-subnet-group"
  subnet_ids = [var.private_subnet_1_id , var.private_subnet_2_id]

  tags = {
    Name = "mysql-subnet-group"
  }
}
