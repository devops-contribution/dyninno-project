data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "minikube_sg" {
  name        = "minikube-security-group"
  description = "Allow Minikube traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Chnage it as per your need.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Get the latest image 
data "aws_ami" "latest_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "minikube" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.minikube_sg.id]


  user_data = file("${path.module}/../scripts/install.sh")

  tags = {
    Name = "minikube-server"
  }
}
