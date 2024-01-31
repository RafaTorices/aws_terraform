# Variables para la VPC
variable "app_name" {
  type        = string
  description = "Nombre de la aplicación"
}
variable "vpc_cidr" {
  description = "CIDR block VPC"
  type        = string
  default     = "10.10.0.0/16" # CIDR de la VPC
}
variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}
variable "destination_cidr_block" {
  description = "CIDR block destino"
  type        = string
  default     = "0.0.0.0/0" # CIDR de la red a la que se va a abrir el acceso, en este caso a Internet
}
