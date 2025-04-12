resource "aws_launch_template" "todoapp_lt" {
  name                   = "todoapp-lt"
  image_id               = var.ami_id
  instance_type          = "t3.small"
  vpc_security_group_ids = [var.application_sg_id]
  user_data              = base64encode(file("${path.module}/user_data.sh"))
  key_name               = var.key_name 
  iam_instance_profile {
    name = var.ec2_instance_profile_name
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "todoapp-instance"
    }
  }
}