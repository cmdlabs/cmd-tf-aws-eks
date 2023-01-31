terraform {
  required_version = " >= 0.14.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.76.1"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1.2"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.1"
    }
  }
}
