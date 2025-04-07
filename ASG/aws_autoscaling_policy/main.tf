resource "aws_autoscaling_policy" "scale_out" {
  name                   = "scale-out-on-high-cpu"
  autoscaling_group_name = var.asg_name
  adjustment_type        = "ChangeInCapacity"
  policy_type           = "StepScaling"

  step_adjustment {
    scaling_adjustment          = 1  # Add 1 instance
    metric_interval_lower_bound = var.target_scale_up
  }
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "scale-in-on-low-cpu"
  autoscaling_group_name = var.asg_name
  adjustment_type        = "ChangeInCapacity"
  policy_type           = "StepScaling"

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_upper_bound = var.target_scale_down
  }
}