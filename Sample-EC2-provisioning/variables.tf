variable "region" {
  description = "The AWS region to create resources in."
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "The EC2 instance type."
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  default     = "ami-0682cb73406023f4f"
}
