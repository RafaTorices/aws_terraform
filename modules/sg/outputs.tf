# Output for Security Group
# Obtenemos el ID de los Security Groups creados
output "ids_security_groups" {
  value = aws_security_group.this.*.id
  description = "Devuelve el ID de los Security Groups creados"
}
