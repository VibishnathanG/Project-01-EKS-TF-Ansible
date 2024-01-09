terraform {
  backend "s3" {
    bucket = "projectbucket-vibish"
    key    = "project-01/jenkins/terrafomr.tfstate"
    region = "ap-south-1"
  }
}
