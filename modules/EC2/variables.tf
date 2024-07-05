variable "ami"{
    description = "Sets the AMI for the EC2 Instance"
    type = string
}

variable "instance_type"{
    description = "Sets the type of the EC2 instance"
    type = string
}
variable "instance_state"{
    description = "Sets the current state of the EC2 instance"
    type = string
}
variable "core_count"{}
variable "threads_per_core" {}

