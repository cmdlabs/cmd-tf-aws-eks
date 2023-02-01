terraform {
  backend "s3" {
    bucket         = "cmdlabtf-terraform-backend"
    key            = "module-cmd-tf-aws-eks"
    region         = "ap-southeast-2"
    profile        = "cmdlabtf-tfbackend"
    dynamodb_table = "cmdlabtf-terraform-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.76.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.17.0"
    }
  }
}

provider "aws" {
  profile = "cmdlabtf-master"
  region  = "ap-southeast-2"
}

data "aws_eks_cluster" "cluster" {
  name = module.cluster.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.cluster.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
