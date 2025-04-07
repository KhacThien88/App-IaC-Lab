resource "aws_eip" "nat_eip_a" {
    vpc = true
    tags = {
        Name = var.tag_eip
    }
}
