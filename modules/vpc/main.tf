# Definición de los recursos de networking en AWS
# VPC en la que se va a desplegar el proyecto
resource "aws_vpc" "this" {
  # Cidr de la VPC que le vamos a asignar
  cidr_block = var.vpc_cidr
  # Habilitamos DNS Hostnames para que las instancias puedan resolver nombres de dominio
  enable_dns_hostnames = true
  tags = {
    Name = "${var.app_name}-vpc"
  }
}
# Subnets de la VPC
resource "aws_subnet" "this" {
  # Vamos a crear tantas subnets como zonas de disponibilidad haya en la región
  count = length(data.aws_availability_zones.this.names)
  # Referencia a la VPC en la que se va a crear la subnet
  vpc_id = aws_vpc.this.id
  # Cidr de las subnets que vamos a generar en las zonas de disponibilidad
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 1)
  # Zona de disponibilidad en la que se va a crear la subnet
  availability_zone       = data.aws_availability_zones.this.names[count.index]
  # Map public IP on launch
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "${var.app_name}-subnet-${count.index + 1}"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "this" {
  # Referencia a la VPC en la que se va a asociar el Internet Gateway
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.app_name}-gateway"
  }
}
# Tabla de rutas para la VPC
resource "aws_route_table" "this" {
  # Referencia a la VPC en la que se va a asociar la tabla de rutas
  vpc_id = aws_vpc.this.id
  # Routes de la tabla de rutas
  route {
    # CIDR de la red a la que se va a abrir el acceso, en este caso a Internet
    cidr_block = var.destination_cidr_block
    # Referencia al Internet Gateway
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.app_name}-route-table"
  }
}
# Asociamos tabla de rutas main a la VPC
resource "aws_main_route_table_association" "this" {
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.this.id
}
