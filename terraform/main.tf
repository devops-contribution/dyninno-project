resource "aws_security_group" "minikube_sg" {
  name        = "minikube-security-group"
  description = "Allow Minikube traffic"
  vpc_id      = var.vpc_id

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


resource "aws_instance" "minikube" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t3.medium"
  vpc_security_group_ids = [aws_security_group.minikube_sg.id]
  subnet_id              = var.subnet_id


  user_data = file("${path.module}/../scripts/install.sh")

  tags = {
    Name = "minikube-server"
  }
}
