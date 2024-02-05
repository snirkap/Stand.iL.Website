module "s3_bucket" {
  count   = var.enable_s3_bucket ? 1 : 0
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = var.s3_bucket_name
  acl    = "private"
  force_destroy = true
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  versioning = {
    enabled = true
  }
  website = {
    index_document = var.s3_bucket_website_index_document
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  count   = var.enable_s3_bucket_policy ? 1 : 0
  bucket = module.s3_bucket[0].s3_bucket_id 
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "3",
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Resource": "arn:aws:s3:::${module.s3_bucket[0].s3_bucket_id}/*", 
      "Condition": {
        "StringEquals": {
          "aws:SourceArn": "${aws_cloudfront_distribution.cloudfront_dist[0].arn}" 
        }
      }
    }
  ]
}
POLICY
}