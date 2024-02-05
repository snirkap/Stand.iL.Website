resource "aws_route53_record" "cloudfront_alias" {
  count   = var.enable_route53_record ? 1 : 0
  zone_id = var.aws_route53_record_zone_id  # Replace with the Route 53 hosted zone ID for your dns name 
  name    = var.aws_route53_record_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudfront_dist[0].domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_dist[0].hosted_zone_id
    evaluate_target_health= true
  }
}