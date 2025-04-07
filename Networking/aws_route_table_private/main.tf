resource "aws_route_table" "private_rt_a" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.ngw_id
  }

  tags = {
    Name = var.tag_rtb_ngw
  }
}