terraform{
resource "aws_security_group" "example" {
  name_prefix = "example-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
#we can use instance_state = "stopped" or instance_state = "hibernate" to manage the state of the ec2 instance 
  tags = {
    Name = "example-instance"
  }
}
}