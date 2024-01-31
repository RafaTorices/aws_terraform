# Desplegamos un file system de EFS
resource "aws_efs_file_system" "this" {
  creation_token = "${var.app_name}-efs"
  tags = {
    Name = "${var.app_name}-efs"
  }
  # Definimos el tipo de performance y throughput que va a tener el file system
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
  # Encriptamos el file system
  encrypted = var.encrypted
}
# Definimos el mount target para el file system de EFS
resource "aws_efs_mount_target" "this" {
  # Contamos el número de subnets que tenemos definidas
  count = length(var.subnets)
  # Referencia al file system de EFS
  file_system_id = aws_efs_file_system.this.id
  # Obtenemos los ids de las subnets
  subnet_id = var.subnets[count.index]
  # Asignamos el security group
  security_groups = var.security_groups
}
