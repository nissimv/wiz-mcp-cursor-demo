provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "insecure_sg" {
  name        = "insecure_sg"
  description = "Allow all inbound traffic"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
