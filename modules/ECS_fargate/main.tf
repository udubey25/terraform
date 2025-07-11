resource "aws_ecs_cluster" "ecs-cluster" {
  name = "var.cluster_name"
}

resource "aws_iam_role" "ecs-task-execution-role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-policy" {
  role = aws_iam_role.ecs-task-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_security_group" "ecs-sg" {
  name = "ecs-flask-sg"
  description = "Allow HTTP access to Flask App"
  vpc_id = var.vpc_id
  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  tags = {
    name = "ecs-flask-sg"
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "/ecs/flask-app"
  retention_in_days = 7
}

resource "aws_ecr_repository" "flask-app-repository" {
  name = "flask-app-repo"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}