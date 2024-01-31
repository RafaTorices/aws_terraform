# Definición de la infraestructura de AWS con Terraform
# Definimos la versión de Terraform que vamos a utilizar y el proveedor de AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # https://registry.terraform.io/providers/hashicorp/aws/latest
      version = "~> 5.0"
    }
  }
}
# Definimos la región de AWS que vamos a utilizar
provider "aws" {
  region = "eu-west-1"
}

