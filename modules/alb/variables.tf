# Variables para el módulo ALB
variable "app_name" {
  type        = string
  description = "Nombre de la aplicación"
}
variable "vpc" {
  type        = string
  description = "VPC en la que se va a desplegar el target group"
}
variable "port" {
  description = "Puerto al que va a escuchar el target group"
  type        = number
  default     = 80
}
variable "protocol" {
  description = "Protocolo al que va a escuchar el target group"
  type        = string
  default     = "HTTP"
}
variable "target_type" {
  description = "Tipo de target, puede ser ip o instance"
  type        = string
  default     = "ip"
}
variable "path" {
  description = "Ruta a la que va a realizar la comprobación"
  type        = string
  default     = "/"
}
variable "timeout" {
  description = "Tiempo de espera para considerar que la task está sana"
  type        = number
  default     = 5
}
variable "interval" {
  description = "Intervalo de tiempo entre comprobaciones en las health checks"
  type        = number
  default     = 30
}
variable "healthy_threshold" {
  description = "Número de comprobaciones consecutivas que tienen que ser correctas para considerar que la task está sana"
  type        = number
  default     = 2
}
variable "unhealthy_threshold" {
  description = "Número de comprobaciones consecutivas que tienen que ser incorrectas para considerar que la task está enferma"
  type        = number
  default     = 2
}
variable "type" {
  description = "Tipo de acción que va a realizar el alb listener"
  type        = string
  default     = "forward"
}
variable "security_groups" {
  description = "Lista de security groups del ALB"
  type        = list(any)
  default     = []
}
variable "subnets" {
  description = "Lista de subredes en las que se va a desplegar el ALB"
  type        = list(any)
  default     = []
}
variable "internal" {
  description = "Si el ALB es interno o externo"
  type        = bool
  default     = false
}
variable "load_balancer_type" {
  description = "Tipo de ALB"
  type        = string
  default     = "application"
}
