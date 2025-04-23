terraform {
  backend "s3" {
    bucket = "mystrapi-ecs"
    key = "terrafrom/terrafrom.tfstate"
    region = "us-east-1"
  }
}
provider "aws" {
  region = var.region
}
