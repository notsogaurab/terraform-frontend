module "frontend" {
    source = "../s3"
    gaurab-test-s3-bucket = var.bucket_name

}

module "cloudfront_distribution" {
    depends_on = [ module.frontend ]
    source = "../cloudfront"
}


module "cloudflare" {
    source = "../cloudflare"

    domain_name = var.domain_name
    cloudfront_domain_name = module.cloudfront_distribution.cloudflare_dns
    # cloudfront_domain_name = module.cloudfront_distribution.domain_name
}