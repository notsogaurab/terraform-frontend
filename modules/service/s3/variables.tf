variable "gaurab-test-s3-bucket" {
  type        = string
  description = "The name of the S3 bucket."
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply to the S3 bucket."
  default     = "private"
}