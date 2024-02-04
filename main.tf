provider "aws" {
  region = "us-east-1" 
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "standil"
  acl    = "private"

  force_destroy = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
  website = {
    index_document = "stand.iL.html"
  }
}

resource "aws_cloudfront_origin_access_control" "site_access" {
  name                              = "site_access"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudfront_dist" {

default_root_object = "stand.iL.html"
  enabled             = true
  is_ipv6_enabled     = true

  origin {
    domain_name = module.s3_bucket.s3_bucket_bucket_domain_name
    origin_id   = module.s3_bucket.s3_bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.site_access.id
  }

  aliases = ["surfsupsnir.com"]

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:064195113262:certificate/266f105d-cce1-4c60-99f1-07d17eb036bd"
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = module.s3_bucket.s3_bucket_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_All"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.s3_bucket.s3_bucket_id # Replace with your actual S3 bucket ID
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
      "Resource": "arn:aws:s3:::${module.s3_bucket.s3_bucket_id}/*", 
      "Condition": {
        "StringEquals": {
          "aws:SourceArn": "${aws_cloudfront_distribution.cloudfront_dist.arn}" 
        }
      }
    }
  ]
}
POLICY
}

resource "aws_route53_record" "cloudfront_alias" {
  zone_id = "Z02699943I5DTUSUR4A3X"  # Replace with the Route 53 hosted zone ID for your dns name 
  name    = "surfsupsnir.com"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront_dist.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_dist.hosted_zone_id
    evaluate_target_health= true
  }
}
