terraform {
  backend "s3" {
    bucket = "projectbucket-vibish"
    key    = "project-01/EKS/terrafomr.tfstate"
    region = "ap-south-1"
  }
}