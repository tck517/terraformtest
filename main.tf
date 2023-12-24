terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }

  backend "s3" {
    bucket = "tck517"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

variable "PR_NUMBER" {
  description = "The pull request number"
  type        = string
}

output "PR_NUMBER" {
  description = "The pull request number"
  value       = "var.PR_NUMBER"
}

resource "aws_dynamodb_table" "academy_table" {
  name           = "academy_table-PR-${var.PR_NUMBER}"
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "prospect_table" {
  name           = "prospect_table-PR-${var.PR_NUMBER}"
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}
