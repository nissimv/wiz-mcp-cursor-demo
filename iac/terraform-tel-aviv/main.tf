provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "tel_aviv_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "tel-aviv-vpc"
  }
}

resource "aws_subnet" "tel_aviv_public_subnet" {
  vpc_id                  = aws_vpc.tel_aviv_vpc.id
  cidr_block              = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  tags = {
    Name = "tel-aviv-public-subnet"
  }
}

resource "aws_internet_gateway" "tel_aviv_igw" {
  vpc_id = aws_vpc.tel_aviv_vpc.id
  tags = {
    Name = "tel-aviv-igw"
  }
}

resource "aws_route_table" "tel_aviv_public_rt" {
  vpc_id = aws_vpc.tel_aviv_vpc.id
  tags = {
    Name = "tel-aviv-public-rt"
  }
}

resource "aws_route" "tel_aviv_public_route" {
  route_table_id         = aws_route_table.tel_aviv_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tel_aviv_igw.id
}

resource "aws_route_table_association" "tel_aviv_public_assoc" {
  subnet_id      = aws_subnet.tel_aviv_public_subnet.id
  route_table_id = aws_route_table.tel_aviv_public_rt.id
}

resource "aws_security_group" "tel_aviv_ssh_sg" {
  name        = "tel-aviv-ssh-sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.tel_aviv_vpc.id

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

resource "aws_iam_role" "tel_aviv_permissive_role" {
  name = "tel-aviv-permissive-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "tel_aviv_permissive_policy" {
  name = "tel-aviv-permissive-policy"
  role = aws_iam_role.tel_aviv_permissive_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "*"
      Resource = "*"
    }]
  })
}

resource "aws_iam_instance_profile" "tel_aviv_instance_profile" {
  name = "tel-aviv-instance-profile"
  role = aws_iam_role.tel_aviv_permissive_role.name
}

resource "aws_instance" "tel_aviv_ec2_1" {
  ami                    = "ami-0ab69690991408217"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.tel_aviv_public_subnet.id
  vpc_security_group_ids = [aws_security_group.tel_aviv_ssh_sg.id]
  associate_public_ip_address = true
  iam_instance_profile   = aws_iam_instance_profile.tel_aviv_instance_profile.name
  tags = {
    Name = "tel-aviv-ec2-1"
  }
}

resource "aws_instance" "tel_aviv_ec2_2" {
  ami                    = "ami-0ab69690991408217"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.tel_aviv_public_subnet.id
  vpc_security_group_ids = [aws_security_group.tel_aviv_ssh_sg.id]
  associate_public_ip_address = true
  iam_instance_profile   = aws_iam_instance_profile.tel_aviv_instance_profile.name
  tags = {
    Name = "tel-aviv-ec2-2"
  }
}

resource "aws_s3_bucket" "tel_aviv_bucket" {
  bucket = "tel-aviv-unique-s3-bucket-${random_id.suffix.hex}"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

output "tel_aviv_ec2_1_id" {
  value = aws_instance.tel_aviv_ec2_1.id
}

output "tel_aviv_ec2_1_public_ip" {
  value = aws_instance.tel_aviv_ec2_1.public_ip
}

output "tel_aviv_bucket_name" {
  value = aws_s3_bucket.tel_aviv_bucket.bucket
} 