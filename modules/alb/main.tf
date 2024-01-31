# Despliegue de un ALB con un listener y un target group
# Definimos un target group para el ALB
resource "aws_lb_target_group" "this" {
  name = "${var.app_name}-tg"
  # Puerto al que va a escuchar el target group
  port = var.port
  # Protocolo al que va a escuchar el target group
  protocol = var.protocol
  # VPC en la que se va a desplegar el target group
  vpc_id = var.vpc
  # Target type puede ser ip o instance - Seleccionamos ip porque vamos a utilizar Fargate en ECS - instance no es compatible con Fargate.
  target_type = var.target_type
  # Definimos el health check que va a realizar el ALB al target group para comprobar que las tasks están funcionando correctamente y balancear el tráfico
  health_check {
    # Ruta a la que va a realizar la comprobación
    path = var.path
    # Puerto al que va a realizar la comprobación
    port = var.port
    # Protocolo al que va a realizar la comprobación
    protocol = var.protocol
    # Tiempo de espera para considerar que la task está sana
    timeout = var.timeout
    # Intervalo de tiempo entre comprobaciones
    interval = var.interval
    # Número de comprobaciones consecutivas que tienen que ser correctas para considerar que la task está sana
    healthy_threshold = var.healthy_threshold
    # Número de comprobaciones consecutivas que tienen que ser incorrectas para considerar que la task está enferma
    unhealthy_threshold = var.unhealthy_threshold
  }
  tags = {
    Name = "${var.app_name}-tg"
  }
}
# Definimos el ALB de tipo application que va a recibir el tráfico y lo va a distribuir entre los target group
resource "aws_lb" "this" {
  name = "${var.app_name}-lb"
  # Tipo de balanceador de carga
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  # Security group del ALB
  security_groups = var.security_groups
  # Definimos la subred en la que se va a desplegar el ALB, tiene que haber al menos dos subredes en zonas de disponibilidad diferentes
  subnets = var.subnets
  tags = {
    Name = "${var.app_name}-lb"
  }
}
# Definimos el listener del ALB que va a recibir el tráfico y lo va a distribuir entre los target group
resource "aws_lb_listener" "this" {
  # Apuntamos al ARN del ALB
  load_balancer_arn = aws_lb.this.arn
  # Puerto al que va a escuchar el listener
  port = var.port
  # Protocolo al que va a escuchar el listener
  protocol = var.protocol
  # Definimos el default action que va a realizar el listener, en este caso hará un forward al target group
  default_action {
    type             = var.type
    target_group_arn = aws_lb_target_group.this.arn
  }
}
