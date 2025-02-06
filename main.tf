provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_version = ">= 0.12" # Specify the appropriate version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Specify the appropriate version
    }
  }

  backend "s3" {
    bucket = "sctp-ce8-tfstate"
    key    = "zirong-tf-ci.tfstate"
    region = "ap-southeast-1"
  }
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = split("/", data.aws_caller_identity.current.arn)[1]
  account_id  = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "s3_tf" {
  bucket = "${local.name_prefix}-s3-tf-bkt-${local.account_id}"
}
