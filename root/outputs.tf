# Outputs Terraform
# Salida de Terraform del endpoint del ALB para acceder a la aplicación web desplegada en ECS con nginx
output "endpoint_nginx" {
  value       = module.alb.dns_alb_endpoint
  description = "Devuelve el dns_name del ALB para poder acceder a la aplicación web en Nginx a través de un navegador"
}
