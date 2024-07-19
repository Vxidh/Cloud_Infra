# Application load balancer
resource "aws_lb" "Application-Load-Balancer"{
    name = "ALB-1"
    internal = false
    load_balancer_type = var.balancer-type
    security_groups    = [aws_security_group.lb_sg.id]
    subnets            = [for subnet in aws_subnet.public : subnet.id]

    enable_deletion_protection = true

    access_logs {
        bucket  = var.bucket-id
        prefix  = "test-lb"
        enabled = true
    }

    tags = {
        Environment = "production"
    }
}

# Change the load_balancer_type variable to accomodate the balancer type