# Provider configuration (AWS)
provider "aws" {
  region  = "ap-south-1"
  profile = "venky-test"
}

resource "aws_launch_template" "example" {
  name_prefix   = "test-launch-template"
  description   = "test Launch Template"
  image_id      = "ami-089fdf62e986e93ea"
  instance_type = "t3a.large"

}

# Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  name                = "test-auto-scaling-group"
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = ["subnet-071d7a4e0bfc9a3f7", "subnet-04cb7f8a857966aae"]
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.example.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300 # 5 minutes
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  name                   = "scale-in-policy"
  autoscaling_group_name = aws_autoscaling_group.example.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300 # 5 minutes
}