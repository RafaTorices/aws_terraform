# Obtenmos las zonas de disponibilidad de la región que estén disponibles
data "aws_availability_zones" "this" {
  state = "available"
}
