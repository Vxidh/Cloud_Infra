output "id" {
  value = aws_lb.ALB-1.lb_id
}

output "DNS-name"{
    value = aws_lb.ALB-1.lb_dns_name
}