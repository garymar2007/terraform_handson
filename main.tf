provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

#resource "aws_instance" "app_server" {
#  ami           = "ami-04b70fa74e45c3917"
#  instance_type = var.ec2_instance_type
#  tags = {
#    Name = var.instance_name
#  }
#}

# VPC
resource "aws_vpc" "my_test_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "my_test_subnet" {
  vpc_id     = aws_vpc.my_test_vpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "my_test_igw" {
  vpc_id = aws_vpc.my_test_vpc.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_test_igw.id
  }
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.my_test_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "my_test_sg" {
  name = "HTTP"
  vpc_id = aws_vpc.my_test_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface" "my_test-ni" {
  subnet_id       = aws_subnet.my_test_subnet.id
  private_ips     = [var.ec2_private_ip]
  security_groups = [aws_security_group.my_test_sg.id]
}

resource "aws_eip" "my_test-eip" {
  domain      = "vpc"
  network_interface = aws_network_interface.my_test-ni.id
  associate_with_private_ip = var.ec2_private_ip
  depends_on = [aws_internet_gateway.my_test_igw, aws_instance.my_test_ec2]
}

resource "aws_instance" "my_test_ec2" {
  ami           = var.ec2_ami
  instance_type = "t2.micro"
  key_name      = "main-key"

  network_interface {
    network_interface_id = aws_network_interface.my_test-ni.id
    device_index         = 0
  }

  user_data = <<-EOF
              #!/bin/bash -ex
              sudo apt update -y
              sudo apt install nginx -y
              sudo bash -c 'echo "<h1>This is my new Server</h1>" > /usr/share/nginx/html/index.html'
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = var.ec2_name
  }
}