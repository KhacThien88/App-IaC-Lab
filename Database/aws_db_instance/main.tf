resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  max_allocated_storage = 100
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.username
  password             = var.password
  db_name              = var.db_name
  publicly_accessible  = true
  storage_type         = "gp2"
  vpc_security_group_ids = [var.sg_db_rds_id]
  db_subnet_group_name = var.db_subnet_group_name
  multi_az             = false
  skip_final_snapshot  = true
  parameter_group_name = "default.mysql8.0"

  tags = {
    Name = "mysql-instance"
  }
}
resource "null_resource" "init_db" {
  depends_on = [aws_db_instance.mysql]

  provisioner "local-exec" {
    command = <<EOF
      echo "Waiting for DB to become available..."
      sleep 200
      mysql -h ${aws_db_instance.mysql.address} \
            -P ${aws_db_instance.mysql.port} \
            -u ${aws_db_instance.mysql.username} \
            -p"${var.password}" < init_db.sql
    EOF

    working_dir = path.module
  }
}
