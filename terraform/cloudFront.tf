variable "domain_name" {
  default = null
}
variable "domain_name_certificate_arn" {
  default = null
}

locals {
  domain_name                 = var.domain_name
  domain_name_certificate_arn = var.domain_name_certificate_arn
}

module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = local.domain_name != null ? [
    local.domain_name
  ] : null
  viewer_certificate = local.domain_name_certificate_arn != null ? {
    acm_certificate_arn = local.domain_name_certificate_arn
    ssl_support_method  = "sni-only"
    } : {
    "cloudfront_default_certificate" : true,
    "minimum_protocol_version" : "TLSv1"
  }

  comment             = "My awesome CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }


  origin = {
    api_gateway = {
      domain_name = "${module.api_gateway.apigatewayv2_api_id}.execute-api.ap-northeast-1.amazonaws.com"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }

    s3_one = {
      domain_name = "terraform-python-sample-bucket.s3.ap-northeast-1.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3_one"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/api/*"
      target_origin_id       = "api_gateway"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]
}
