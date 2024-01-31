# Variables para el módulo EFS
variable "app_name" {
  type        = string
  description = "Nombre de la aplicación"
}
variable "performance_mode" {
  description = "Tipo de performance que va a tener el file system"
  type        = string
  default     = "generalPurpose"
}
variable "throughput_mode" {
  description = "Tipo de throughput que va a tener el file system"
  type        = string
  default     = "bursting"
}
variable "encrypted" {
  description = "Indica si el file system va a estar encriptado"
  type        = bool
  default     = false
}
variable "subnets" {
  description = "Subnets en las que se va a crear el mount target"
  type        = list(any)
  default     = []
}
variable "security_groups" {
  description = "Security groups del mount target"
  type        = list(any)
  default     = []
}
