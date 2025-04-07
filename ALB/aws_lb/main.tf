resource "aws_lb" "application-lb" {
  name               = "webservers-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb-sg-id]
  subnets            = [var.public_subnet_1_id,var.public_subnet_2_id]
  tags = {
    Name = "Webservers-LB"
  }
}
