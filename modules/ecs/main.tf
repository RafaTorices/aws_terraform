# Definimos el Cluster ECS
resource "aws_ecs_cluster" "this" {
  name = "${var.app_name}-cluster"
  tags = {
    Name = "${var.app_name}-cluster"
  }
}
# Definimos la task que vamos a ejecutar en el cluster
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}-task"
  network_mode             = var.network_mode             # Tipo de networking que va a utilizar la task - para ECS Fargate usar: awsvpc
  requires_compatibilities = var.requires_compatibilities # Tipo de lanzamiento de la task
  memory                   = var.memory                   # Memoria en MB que va a utilizar la task
  cpu                      = var.cpu                      # CPU en unidades de CPU que va a utilizar la task
  tags = {
    Name = "${var.app_name}-task"
  }
  # Definimos el contenedor que va a ejecutar la task dentro del cluster pasando a formato json el objeto
  container_definitions = jsonencode([
    {
      name  = "${var.app_name}-container"
      image = var.image
      command = [
        "sh",
        "-c",
        "echo '<body style=\"background-color: black; color: gold; font-size: larger\"><h1 align=\"center\" style=\"margin-top: 3em\">RAFAEL TORICES<br>KeepCoding<br>Test Nginx ECS - Fargate<br>AWS Terraform</h1></body>' > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
      ]
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
        }
      ]
      essential = true
      cpu       = var.cpu
      memory    = var.memory
      mountPoints = [
        {
          sourceVolume  = "${var.app_name}-efs"
          containerPath = var.container_path
        }
      ]
    }
  ])
  # Definimos el volumen que va a utilizar la task para hacer persistente la información
  volume {
    name = "${var.app_name}-efs"
    efs_volume_configuration {
      # Referencia al file system de EFS
      file_system_id = var.id_efs_file_system
      # Montamos el directorio raíz del file system de EFS
      root_directory = "/"
    }
  }
}
# Definimos el servicio que va a ejecutar la task dentro del cluster
resource "aws_ecs_service" "this" {
  name             = "${var.app_name}-service"
  cluster          = aws_ecs_cluster.this.id         # Referencia al cluster
  task_definition  = aws_ecs_task_definition.this.id # Referencia a la task
  desired_count    = var.desired_count               # Cantidad de tasks que queremos que se ejecuten
  launch_type      = var.launch_type                 # Tipo de lanzamiento de la task
  platform_version = var.platform_version            # Versión de la plataforma de ECS
  # Definimos la red en la que se va a ejecutar la task
  network_configuration {
    assign_public_ip = var.assign_public_ip # Asignamos una IP pública
    subnets          = var.subnets          # Referencia a las subnets en las que se va a ejecutar la task
    security_groups  = var.security_groups  # Referencia al security group
  }
  # Definimos el balanceador de carga que va a recibir el tráfico y lo va a distribuir entre las tasks
  load_balancer {
    target_group_arn = var.target_group_arn        # Referencia al target group
    container_name   = "${var.app_name}-container" # Referencia al contenedor que va a recibir el tráfico
    container_port   = var.port                    # Puerto del contenedor que va a recibir el tráfico
  }
  # Tags del servicio
  tags = {
    Name = "${var.app_name}-service"
  }
}
