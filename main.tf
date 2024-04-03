# module "s3_bucket" {
#     source = "./modules/service/s3"
#     gaurab-test-s3-bucket = "gaurab-test-s3-bucket"
# }

# module "cloudfront_distribution" {
#     depends_on = [ module.s3_bucket ]
#     source = "./modules/service/cloudfront"
    
# }

# module "cloudflare" {
#     source = "./modules/service/cloudflare"
#     domain_name = "gaurabupreti.com"
#     cloudfront_domain_name = module.cloudfront_distribution.cloudflare_dns

# }

module "workflow" {
    source = "git@github.com:notsogaurab/terraform-frontend.git//modules/service/workflow"
    domain_name = "gaurabupreti.com"
}