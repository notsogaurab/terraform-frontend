data "aws_s3_bucket" "s3" {
  bucket = "gaurab-test-s3-bucket"
}

output "s3_bucket" {
    value = data.aws_s3_bucket.s3.bucket
}


# Data source for IAM policy document
data "aws_iam_policy_document" "cloudfront_policy" {
    depends_on = [ aws_cloudfront_distribution.s3_distribution, data.aws_s3_bucket.s3 ]
  statement {
    actions   = ["s3:GetObject"]
    resources = [ "arn:aws:s3:::${data.aws_s3_bucket.s3.id}/*" ]

    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }
    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
        values = [ aws_cloudfront_distribution.s3_distribution.arn ]
    }
  }
}

# Attach bucket policy using data
resource "aws_s3_bucket_policy" "bucket_policy" {
    depends_on = [ aws_cloudfront_distribution.s3_distribution ]
  bucket = data.aws_s3_bucket.s3.id

  policy = data.aws_iam_policy_document.cloudfront_policy.json
}


resource "aws_cloudfront_distribution" "s3_distribution" {
    depends_on = [ data.aws_s3_bucket.s3, aws_cloudfront_origin_access_control.s3_distribution ]
    # Set the origin domain name to the S3 bucket
    origin {
        # domain_name = "${data.aws_s3_bucket.s3.id}.s3.amazonaws.com"
        domain_name = "${data.aws_s3_bucket.s3.id}.s3.amazonaws.com"
        # origin_id   = data.aws_s3_bucket.s3.id
        origin_id   = data.aws_s3_bucket.s3.id
        origin_access_control_id = aws_cloudfront_origin_access_control.s3_distribution.id
    }

    # Set the default cache behavior
    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = data.aws_s3_bucket.s3.id

        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
    }

    # Set the viewer certificate for HTTPS support
    viewer_certificate {
        cloudfront_default_certificate = true
        # acm_certificate_arn = "your-acm-certificate-arn"
        # ssl_support_method = "sni-only"
    }

    # Set the price class for the CloudFront distribution
    price_class = "PriceClass_100"

    # Set the default root object
    default_root_object = "index.html"

    # # Set the logging configuration
    # logging_config {
    #     bucket         = "your-logging-bucket"
    #     include_cookies = false
    #     prefix         = "cloudfront-logs/"
    # }

    # Set the tags for the CloudFront distribution
    tags = {
        Name      = "s3-cloudfront-distribution",
        Deletable = "Yes",
        Project   = "Intern",
        Creator   = "gauravupreti1230@gmail.com"
    }

    # Add restrictions block
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    # Add enabled attribute
    enabled = true

}
resource "aws_cloudfront_origin_access_control" "s3_distribution" {
    name                              = "OriginAccessControl1"
    description                       = "OAC for S3 bucket"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "always"
    signing_protocol                  = "sigv4"
}