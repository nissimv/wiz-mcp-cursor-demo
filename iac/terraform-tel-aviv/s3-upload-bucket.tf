terraform {
  backend "s3" {
    bucket = "tel-aviv-tfstate-bucket-main-office"
    key    = "terraform/state/s3-upload-bucket.tfstate"
    region = "us-west-2"
  }
}

#provider "aws" {
#  region = "us-west-2"
#}

resource "random_id" "upload_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "upload_bucket" {
  bucket = "tel-aviv-upload-bucket-${random_id.upload_suffix.hex}"
  force_destroy = true
  tags = {
    Name = "tel-aviv-upload-bucket"
  }
}

output "upload_bucket_name" {
  value = aws_s3_bucket.upload_bucket.bucket
} 