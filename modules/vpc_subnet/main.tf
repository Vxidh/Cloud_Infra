resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name= var.vpc-name
  }
}

resource "aws_subnet" "subnet" {
  for_each = var.subnet-details
  cidr_block = each.value
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = each.key
  }
}