resource "aws_s3_bucket" "S3-Bucket"{
    bucket = var.bucket_name
    tags = {
        Name        = "My bucket"
        Environment = "Dev"
  }
}
resource "aws_s3_bucket_ownership_controls" "S3-Owner" {
  bucket = aws_s3_bucket.S3-Bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "S3-PA-Block" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.S3-Owner,
    aws_s3_bucket_public_access_block.S3-PA-Block,
  ]

  bucket = aws_s3_bucket.S3-Bucket.id
  acl    = var.acl
}

resource "aws_s3_bucket_request_payment_configuration" "example" {
  bucket = aws_s3_bucket.S3-Bucket.id
  payer  = "Requester" //Can be set to BucketOwner or Requester
}