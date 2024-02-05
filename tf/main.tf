module "s3_bucket" {
  source = "./modules"
  enable_cloudfront = true
  enable_route53_record = true
  enable_s3_bucket = true
  enable_s3_bucket_policy = true
  enable_cloudfront_origin_access_control = true
}

