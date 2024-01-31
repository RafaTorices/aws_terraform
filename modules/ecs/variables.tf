# Variables para el módulo ECS
variable "app_name" {
  type        = string
  description = "Nombre de la aplicación"
}
variable "subnets" {
  description = "Lista de subnets en las que se va a ejecutar la task"
  type        = list(any)
  default     = []
}
variable "security_groups" {
  description = "Lista de security groups de la task"
  type        = list(any)
  default     = []
}
variable "network_mode" {
  description = "Tipo de networking que va a utilizar la task - para ECS Fargate usar: awsvpc"
  type        = string
  default     = "awsvpc"
}
variable "requires_compatibilities" {
  description = "Tipo de lanzamiento de la task"
  type        = list(string)
  default     = ["FARGATE"]
}
variable "cpu" {
  description = "CPU en unidades de CPU que va a utilizar la task"
  type        = number
  default     = 512
}
variable "memory" {
  description = "Memoria en MB que va a utilizar la task"
  type        = number
  default     = 1024
}
variable "desired_count" {
  description = "Cantidad de tasks que queremos que se ejecuten"
  type        = number
  default     = 2
}
variable "launch_type" {
  description = "Tipo de lanzamiento de la task"
  type        = string
  default     = "FARGATE"
}
variable "platform_version" {
  description = "Versión de la plataforma de ECS"
  type        = string
  default     = "LATEST"
}
variable "assign_public_ip" {
  description = "Asignamos una IP pública"
  type        = bool
  default     = true
}
variable "image" {
  description = "Imagen del contenedor que va a ejecutar la task"
  type        = string
}
variable "port" {
  description = "Puerto al que va a escuchar el target group"
  type        = number
  default     = 80
}
variable "container_path" {
  description = "Path del contenedor"
  type        = string
}
variable "target_group_arn" {
  description = "ARN del target group"
  type        = string
}
variable "id_efs_file_system" {
  description = "ID del file system de EFS"
  type        = string
}
variable "container_name" {
  description = "Nombre del contenedor"
  type        = string
}
