resource "aws_autoscaling_group" "todoapp_asg" {
  name                 = "todoapp-asg"
  vpc_zone_identifier  = [var.private_subnet_1_id , var.private_subnet_2_id]
  target_group_arns    = [var.alb_target_group_arn]
  min_size             = 2
  max_size             = 6
  desired_capacity     = 2

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
}
