resource "aws_cloudfront_origin_access_control" "site_access" {
  count   = var.enable_cloudfront_origin_access_control ? 1 : 0
  name                              = var.aws_cloudfront_origin_access_control_name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudfront_dist" {
  count   = var.enable_cloudfront ? 1 : 0
  default_root_object = var.s3_bucket_website_index_document
  enabled             = true
  is_ipv6_enabled     = true

  origin {
    domain_name = module.s3_bucket[0].s3_bucket_bucket_domain_name
    origin_id   = module.s3_bucket[0].s3_bucket_id
    origin_access_control_id = aws_cloudfront_origin_access_control.site_access[0].id
  }

  aliases = [var.aws_cloudfront_distribution_aliases]

  viewer_certificate {
    acm_certificate_arn      = var.aws_cloudfront_distribution_acm_certificate_arn
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = module.s3_bucket[0].s3_bucket_id

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