resource "aws_nat_gateway" "nat_gw" {
  allocation_id = var.eip_id
  subnet_id     = var.subnet_id

  tags = {
    Name = var.tag_ngw
  }
}
