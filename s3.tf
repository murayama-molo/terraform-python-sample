data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "1"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${module.cdn.cloudfront_distribution_id}"
      ]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::terraform-python-sample-bucket/",
      "arn:aws:s3:::terraform-python-sample-bucket/*"
    ]
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terraform-python-sample-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

  # Bucket policies
  attach_policy                         = true
  policy                                = data.aws_iam_policy_document.bucket_policy.json
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true
}

resource "aws_s3_bucket_object" "index_page" {
  bucket       = module.s3_bucket.s3_bucket_id
  key          = "index.html"
  source       = "./front/dist/index.html"
  content_type = "text/html"
  etag         = filemd5("front/dist/index.html")
}
