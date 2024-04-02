provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "aws_s3_bucket_example" {
    bucket = var.gaurab-test-s3-bucket
    
    tags = {
        Name = "gaurab-test-s3-bucket"
        Creator = "gauravupreti1230@gmail.com"
        Project = "Intern"
        Deletable = "Yes"
        }

website {
    index_document = "index.html"
    error_document = "error.html"
}
}

resource "aws_s3_object" "dist_file" {
  bucket = aws_s3_bucket.aws_s3_bucket_example.id
  key    = each.value
  

  content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "json" = "application/json",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "svg"  = "image/svg+xml"
  }, element(split(".", basename(each.value)), length(split(".", basename(each.value))) - 1), "binary/octet-stream")
  for_each = fileset("/home/notsogaurab/leapfrog-assignments/three-tier-app/frontend/dist", "**/*")

  source = "/home/notsogaurab/leapfrog-assignments/three-tier-app/frontend/dist/${each.value}"

}
