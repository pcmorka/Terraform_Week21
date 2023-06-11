#Create Bucket for storing the state of our infrastructure resources
resource "aws_s3_bucket" "wk21proj-s3bucket-060323" {
  bucket = "wk21proj-s3bucket-060323"

  tags = {
    Name        = "My bucket"
    Environment = "dev"
  }
}

#Enable versioning
resource "aws_s3_bucket_versioning" "wk21proj-s3bucket-060323" {
  bucket = aws_s3_bucket.wk21proj-s3bucket-060323.id

  versioning_configuration {
    status = "Enabled"
  }
}

#Block public access to our S3 bucket
resource "aws_s3_bucket_public_access_block" "wk21proj-s3bucket-060323-accessblock" {
  bucket = aws_s3_bucket.wk21proj-s3bucket-060323.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

terraform {
  backend "s3" {
    bucket = "wk21proj-s3bucket-060323"
    key    = "State-Files/terraform.tfstate"
    region = "us-east-1"
  }
}