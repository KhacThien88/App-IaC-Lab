resource "aws_route_table" "route-table" {
  vpc_id   = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw-id
  }

  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = var.tag
  }
}
