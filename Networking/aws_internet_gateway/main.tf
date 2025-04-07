resource "aws_internet_gateway" "igw" {
  vpc_id   = var.id_vpc

  tags = {
    Name = var.tag
  }
}