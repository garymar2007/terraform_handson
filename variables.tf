#variable "instance_name" {
#  description = "The AMI to use for the instance"
#  type        = string
#  default     = "MyNewInstance"
#}
#
#variable "ec2_instance_type" {
#  description = "AWS EC2 instance type to use for the instance"
#  type        = string
#  default     = "t2.micro"
#}

# Real Scenario
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "MyTestVPC"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "MyTestSubnet"
}

variable "igw_name" {
  description = "The name of the internet gateway"
  type        = string
  default     = "MyTestIGW"
}

variable "ec2_ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}

variable "ec2_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = "MyTestEC2"
}

variable "ec2_private_ip" {
  description = "The private IP address for the EC2 instance"
  type        = string
  default     = "10.0.1.50"
}