resource "aws_route_table" "main" {
  vpc_id = var.vpc-id
  for_each=var.route_cidr_block
  route{
    cidr_block = each.value
    gateway_id = each.key
  }
}