variable "s3_bucket_name" {
  type        = string
  description = "the name of the bucket"
  default     = "standiltf"
}

variable "s3_bucket_website_index_document" {
  type        = string
  description = "the default file for the static website"
  default     = "stand.iL.html"
}

variable "aws_cloudfront_origin_access_control_name" {
  type        = string
  description = "the name of aws cloudfront origin access control"
  default     = "site_access"
}

variable "aws_cloudfront_distribution_aliases" {
  type        = string
  description = "aliases for alternate domain"
  default     = "surfsupsnir.com"
}

variable "aws_cloudfront_distribution_acm_certificate_arn" {
  type        = string
  description = "acm certificate arn"
  default     = "arn:aws:acm:us-east-1:064195113262:certificate/266f105d-cce1-4c60-99f1-07d17eb036bd"
}

variable "aws_route53_record_zone_id" {
  type        = string
  description = "zone id"
  default     = "Z02699943I5DTUSUR4A3X"
}

variable "aws_route53_record_name" {
  type        = string
  description = "name of the record"
  default     = "surfsupsnir.com"
}

variable "enable_cloudfront_origin_access_control" {
  type        = bool
  description = "whether to deploy cloudfront origin access control"
}

variable "enable_cloudfront" {
  type        = bool
  description = "whether to deploy cloudfront"
}

variable "enable_s3_bucket" {
  type        = bool
  description = "whether to deploy s3 bucket"
}

variable "enable_s3_bucket_policy" {
  type        = bool
  description = "whether to deploy s3 bucket policy"
}

variable "enable_route53_record" {
  type        = bool
  description = "whether to deploy route53 record"
}



