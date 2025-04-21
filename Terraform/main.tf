provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "strapi" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu 20.04 in us-east-1
  instance_type = "t2.micro"
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io
              sudo systemctl start docker
              sudo docker pull ${var.docker_image}:${var.image_tag}
              sudo docker run -d -p 80:1337 ${var.docker_image}:${var.image_tag}
            EOF

  tags = {
    Name = "StrapiServer"
  }

  vpc_security_group_ids = [aws_security_group.strapi_sg.id]
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow HTTP and SSH access"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Web"
    from_port   = 80
    to_port     = 80
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

