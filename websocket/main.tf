terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = "~> 2.42"
  }

  backend "s3" {
    bucket = "flyingstates"
    key    = "websocket.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}