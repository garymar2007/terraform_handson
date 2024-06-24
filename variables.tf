variable "instance_name" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "MyNewInstance"
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type to use for the instance"
  type        = string
  default     = "t2.micro"
}