provider "aws" {
  region     = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_security_group" "web_server" {
  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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

resource "aws_instance" "ubuntu_test" {
  ami = "ami-012ae45a4a2d92750"
  instance_type = "t3.micro"
  vpc_security_group_ids =[aws_security_group.web_server.id]
  key_name = "test"
  user_data = file("apache_bench_script.sh")
  tags = {
    Name = "Test"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size =12
    volume_type = "gp2"
  }
}

