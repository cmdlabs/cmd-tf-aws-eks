terraform {
  required_version = ">= 0.12.26"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.55.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.1"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1.2"
    }
  }
}
