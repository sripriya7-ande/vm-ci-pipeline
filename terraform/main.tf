provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "frontend" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  tags = {
    Name = "c8.local"
  }
}

resource "aws_instance" "backend" {
  ami           = "ami-04505e74c0741db8d"  # Ubuntu 21.04 (or latest close match)
  instance_type = "t2.micro"
  tags = {
    Name = "u21.local"
  }
}

output "frontend_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_ip" {
  value = aws_instance.backend.public_ip
}
