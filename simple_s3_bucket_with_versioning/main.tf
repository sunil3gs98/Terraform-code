resource "aws_s3_bucket" "example" {
  bucket = "sunil3gs98"    #bucket name should alway be unique
}


resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id          #enabling versiniong
  versioning_configuration {
    status = "Enabled"
  }
}
