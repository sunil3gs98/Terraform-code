resource "aws_s3_bucket" "example" {
  for_each = toset(var.iamuser)
  #bucket = each.value
  bucket="${each.value}-s3-example"
}


resource "aws_s3_bucket_acl" "example" {
  for_each =aws_s3_bucket.example
  bucket = each.value.bucket
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  for_each = aws_s3_bucket.example
  bucket   = each.value.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
