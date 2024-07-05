output "id" {
  value = [for rt in aws_route_table.main: rt.id]
}
