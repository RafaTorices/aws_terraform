# Despliegue de recursos del proyecto
# Despligue de VPC
module "vpc" {
  source = "../modules/vpc"
  # Datos del módulo
  app_name                = var.app_name
  vpc_cidr                = "10.10.0.0/16"
  map_public_ip_on_launch = true
  destination_cidr_block  = "0.0.0.0/0"
}
# Despligue de ECS
module "ecs" {
  source = "../modules/ecs"
  # Datos del módulo
  app_name           = var.app_name
  cpu                = 512
  memory             = 1024
  desired_count      = 2
  port               = 80
  image              = "nginx:latest"
  container_path     = "/usr/share/nginx/html"
  container_name     = "${var.app_name}-container"
  subnets            = module.vpc.ids_subnets
  security_groups    = module.sg.ids_security_groups
  target_group_arn   = module.alb.arn_target_group
  id_efs_file_system = module.efs.id_efs_file_system
}
# Despligue de EFS
module "efs" {
  source = "../modules/efs"
  # Datos del módulo
  app_name = var.app_name
  # Obtenemos los ids de las subnets
  subnets = module.vpc.ids_subnets
  # Obtenemos los ids de los security groups
  security_groups = module.sg.ids_security_groups
  # Lo definimos encriptado
  encrypted = true
}
# Despligue de Security Group
module "sg" {
  source = "../modules/sg"
  # Datos del módulo
  app_name    = var.app_name
  vpc         = module.vpc.id_vpc
  port        = 80
  protocol    = "tcp"
  self        = false
  cidr_blocks = ["0.0.0.0/0"]
}
# Despligue de ALB
module "alb" {
  source = "../modules/alb"
  # Datos del módulo
  app_name            = var.app_name
  vpc                 = module.vpc.id_vpc
  security_groups     = module.sg.ids_security_groups
  subnets             = module.vpc.ids_subnets
  port                = 80
  protocol            = "HTTP"
  target_type         = "ip"
  path                = "/"
  timeout             = 5
  interval            = 20
  healthy_threshold   = 2
  unhealthy_threshold = 2
  type                = "forward"
}
