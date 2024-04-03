variable "bucket_name" {
  description = "The name of the bucket to store the workflow state"
  type        = string
  default = "gaurab-test-s3-bucket"
}

variable "domain_name" {
  description = "The domain name to be used for the cloudfront distribution"
  type        = string
  default = "gaurabupreti.com" 
}