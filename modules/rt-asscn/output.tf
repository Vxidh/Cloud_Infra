output "id" {
  value = aws_route_table_association.main[*].id
}