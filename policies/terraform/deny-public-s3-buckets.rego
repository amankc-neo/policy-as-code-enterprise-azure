package terraform.deny_public_s3

deny[msg] {
  input.resource.aws_s3_bucket[_].acl == "public-read"
  msg := "Public S3 buckets are not allowed"
}
