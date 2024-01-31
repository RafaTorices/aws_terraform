# Outputs for VPC
output "id_vpc" {
  value = aws_vpc.this.id
  description = "Devuelve el ID de la VPC creada"
}
# Outputs for Subnets
output "ids_subnets" {
  value = aws_subnet.this.*.id
  description = "Devuelve el ID de las Subnets creadas"
}
