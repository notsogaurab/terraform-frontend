terraform {
  required_version = "1.7.5"

  backend local {
        path ="./localstate.tfstate"    
    }
  required_providers {  
    aws = {
      source = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["/home/notsogaurab/.aws/credentials"]
  shared_config_files = ["/home/notsogaurab/.aws/config"]

  default_tags {
    tags = {
      Creator = "gauravupreti1230@gmail.com"
      Project = "Intern"
      Deletable = "Yes"
    }
  }
}




