data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# 1. APPLICATION LOAD BALANCER
resource "aws_lb" "app_alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  internal           = false

  security_groups = [var.alb_sg_id]
  subnets         = var.public_subnet_ids
}

# 2. TARGET GROUP
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = var.lb_target_group_port
  protocol = var.lb_target_group_protocol

  vpc_id = var.vpc_id

  health_check {
    path = "/health"
  }
}

# 3. ALB LISTENER
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# 4. LAUNCH TEMPLATE
resource "aws_launch_template" "app" {
  name_prefix   = "app-lt-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker

    sudo docker run -d -p 8080:80 nginx
  EOF
  )
}

# 5. AUTO SCALING GROUP
resource "aws_autoscaling_group" "app_asg" {
  name = "app-asg"

  min_size         = 2
  max_size         = 6
  desired_capacity = 2

  vpc_zone_identifier = var.private_subnet_ids

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
}

# 6. SCALING POLICY
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "cpu-scale-out"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name

  policy_type        = var.policy_type
  adjustment_type    = var.adjustment_type
  scaling_adjustment = 1
  cooldown           = 300
}