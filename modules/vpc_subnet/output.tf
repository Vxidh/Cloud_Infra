output "vpc_ids" {
  value = aws_vpc.vpc[*].id
}

output "subnet_ids" {
  value = [for subnet in aws_subnet.subnet : subnet.id]
}