resource "aws_route_table_association" "main" {
  for_each = var.subnet-id
  subnet_id      = each.key
  route_table_id = var.route_table_id
}

// The structure of subnet-id has to be a JSON dictionary so that it can be parsed appropriately