resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "Allow rds access"
  vpc_id      = var.vpc_master_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/24"]
  }
  tags = {
    Name = "db-sg"
  }
}