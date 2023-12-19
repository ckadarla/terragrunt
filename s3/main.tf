resource "aws_s3_bucket" "my_bucket" {
  bucket = "terrastate-s3"
  acl    = "public-read"

  versioning {
    enabled = false
  }

  tags = {
    Name = "MyS3Bucket"
  }
}

output "my_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "my_bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}
