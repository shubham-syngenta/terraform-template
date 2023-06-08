# variable "aws_access_key" {}
# variable "aws_secret_access_key" {}
# variable "aws_region" {}
variable "bucket_name" {}

provider "aws" {
#   access_key = var.aws_access_key
#   secret_access_key = var.aws_secret_access_key
#   region = var.aws_region
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}
