# Outputs for Application Load Balancer
# Generamos el output del arn del target group para poder referenciarlo desde el módulo de ECS
output "arn_target_group" {
  value = aws_lb_target_group.this.arn
  description = "Devuelve el ARN del target group"
}
# Generamos el output del endpoint para obtener la DNS a la que apunta el ALB para nuestro servicio y así exponer el endpoint de nuestra aplicación
output "dns_alb_endpoint" {
    value = aws_lb.this.dns_name
    description = "Devuelve el dns_name del ALB para poder acceder a la aplicación web"
}