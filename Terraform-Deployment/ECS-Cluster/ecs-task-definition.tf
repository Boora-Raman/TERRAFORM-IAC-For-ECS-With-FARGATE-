resource "aws_ecs_task_definition" "TD" {
  family                   = "medusa-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "4096"
  memory                   = "8192"
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = "medusa"
      image = "booraraman/medusa:7c003a6638b12650107fd4e6865ee418ec1be385"
      essential = true
      portMappings = [
        {
          containerPort = 9000
          hostPort      = 9000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/medusa-service"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "medusa"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ])

  lifecycle {
    create_before_destroy = true
  }
}
