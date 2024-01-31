# Variables para el módulo de security group
variable "app_name" {
  type        = string
  description = "Nombre de la aplicación"
}
variable "vpc" {
  type        = string
  description = "VPC en la que se va a desplegar el security group"
}
variable "port" {
  description = "Puerto al que va a escuchar el target group"
  type        = number
  default     = 80
}
variable "protocol" {
  description = "Protocolo al que va a escuchar el target group"
  type        = string
  default     = "tcp"
}
variable "self" {
  description = "Si se permite el acceso desde la misma IP"
  type        = bool
  default     = false
}
variable "cidr_blocks" {
  description = "Lista de CIDR blocks desde los que se va a permitir el acceso, en este caso a Internet"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "port_efs" {
  description = "Puerto para el acceso al file system de EFS"
  type        = number
  default     = 2049
}
variable "protocol_efs" {
  description = "Protocolo para el acceso al file system de EFS"
  type        = string
  default     = "tcp"
}

