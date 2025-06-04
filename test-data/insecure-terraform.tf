resource "aws_s3_bucket" "bad_bucket" {
  bucket = "my-unsecure-bucket"
  acl    = "public-read"
}
