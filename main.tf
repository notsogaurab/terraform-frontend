module "s3_bucket" {
    source = "git@github.com:notsogaurab/terraform-frontend.git//modules/service/s3"
    gaurab-test-s3-bucket = "gaurab-test-s3-bucket"
}

module "cloudfront_distribution" {
    source = "git@github.com:notsogaurab/terraform-frontend.git//modules/service/cloudfront"
    
}

module "cloudflare" {
    source = "git@github.com:notsogaurab/terraform-frontend.git//modules/service/cloudflare"
    domain_name = "gaurabupreti.com"
    cloudfront_domain_name = module.cloudfront_distribution.cloudflare_dns

}