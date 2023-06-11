# Security Group for the ec2 server
resource "aws_security_group" "wk21proj-sg" {
  name_prefix = "wk21proj-sg"
  description = "Security group"
  vpc_id      = var.vpc_id

  # allow access on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow access on port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wk21proj-sg"
  }
}

# Create Launch Template that will install and run Apache Server
resource "aws_launch_template" "wk21proj-lt" {
  name          = "wk21proj-lt"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = filebase64("${path.module}/${var.user_data_file}")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "wk21proj-instance"
    }
  }
}

resource "aws_autoscaling_group" "wk21proj-asg" {
  name                      = "wk21proj-asg"
  desired_capacity          = 2
  max_size                  = 5
  min_size                  = 2
  vpc_zone_identifier       = [var.subnet_id_2, var.subnet_id_1]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.wk21proj-lt.id
    version = "$Latest"
  }
}



