# Defición de grupos de seguridad
# Security Group para que se pueda acceder a la aplicación web
resource "aws_security_group" "this" {
  name   = "${var.app_name}-sg"
  vpc_id = var.vpc # Referencia a la VPC
  # Inbound rules
  ingress {
    # Abriremos el puerto para que se pueda acceder a la aplicación web
    from_port   = var.port
    to_port     = var.port
    protocol    = var.protocol
    self        = var.self
    cidr_blocks = var.cidr_blocks
    description = "HTTP"
  }
  ingress {
    # Abriremos el puerto para que se pueda acceder al file system de EFS
    from_port   = var.port_efs
    to_port     = var.port_efs
    protocol    = var.protocol_efs
    cidr_blocks = var.cidr_blocks
    description = "EFS"
  }
  # Outbound rules
  egress {
    # Permitimos todo el tráfico saliente para que se pueda acceder a internet desde la instancia
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ALL"
  }
  tags = {
    Name = "${var.app_name}-sg"
  }
}
