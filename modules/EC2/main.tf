resource "aws_instance" "EC2-Instance"{
    ami = var.ami
    instance_type = var.instance_type
    cpu_options {
    core_count       = 2 //can be changed
    threads_per_core = 2
  }
}

resource "aws_ec2_instance_state" "test" {
  instance_id = aws_instance.test.id
  state       = var.instance_state
}