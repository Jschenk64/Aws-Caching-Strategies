resource "aws_launch_template" "app" {
  name_prefix            = "app-server"
  image_id               = "ami-00dc61b35bec09b72" # Replace with Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app.id]
}

resource "aws_autoscaling_group" "app" {
  vpc_zone_identifier = aws_subnet.public[*].id
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1

  launch_template {
    id = aws_launch_template.app.id
  }
}