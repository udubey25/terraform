resource "aws_lb" "flask-app-lb" {
  name = "flask-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = ["var.security_groups"]
  subnets = ["var.subnets"]
}

resource "aws_lb_target_group" "flask_tg" {
  name     = "flask-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = "var.vpc_id"
  target_type = "ip"
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "flask_listener" {
  load_balancer_arn = aws_lb.flask-app-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask_tg.arn
  }
}