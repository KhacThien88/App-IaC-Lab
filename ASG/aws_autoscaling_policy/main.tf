resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "scale-up-policy"
  autoscaling_group_name   = var.asg_name
  policy_type             = "StepScaling"

  adjustment_type         = "ChangeInCapacity"
  scaling_adjustment      = 1

  step_adjustment {
    metric_interval_lower_bound = var.target_scale_up
    scaling_adjustment          = 1
  }

  cooldown                 = 300
}
resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "scale-down-policy"
  autoscaling_group_name   = var.asg_name
  policy_type            = "StepScaling"

  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1

  step_adjustment {
    metric_interval_upper_bound = var.target_scale_down
    scaling_adjustment          = -1
  }

  cooldown                 = 300
}
