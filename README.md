# cmd-tf-aws-eks

## Summary
This repository provides a number of submodules that create various parts of an EKS cluster.

- cluster
- nodegroup
- irsa_role

## Cluster
The cluster module is responsible for creating an EKS control plane. Supports the following features;
- Public/Private Endpoints
- IAM Roles for Service Accounts
- Automatic tagging of Public/Private VPC Subnets with cluster tags
- AWS Auth configmap creation/updates

Further options can be found in the modules README.

### AWS Auth Roles
It is possible for the cluster module to manage the aws-auth configmap. However there are some limitations around this;
- Provider chaining is not officially supported by Terraform so this may break one day
- When the AWS API reports the EKS cluster has been created it is not always available immediately to recieve traffic. This results in a null_resource being used to check the API is actually up before the Kubernetes provider starts. This requires curl available locally and it is recommended that you use a docker image like cmdlabs/terraform-utils to deploy this module as a result.

### Provider Configuration
As the cluster module uses the AWS and Kubernetes provider the `provider.tf` is more complex than normal. As a result a sample is included below.
```hcl
provider "aws" {
  version                 = "2.55.0"
  region                  = "ap-southeast-2"
  skip_metadata_api_check = true
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
  load_config_file       = false
  version                = "1.11.1"

  # Use exec plugin to obtain a token.  This is needed because terraform doesn't refresh state on a destroy,
  # so it is unable to successfully authenticate to k8s to remove the configmap resource.
  # See https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#stacking-with-managed-kubernetes-cluster-resources
  # and https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#exec-plugins for more information.
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["--profile", local.workspace["aws_profile"], "eks", "get-token", "--cluster-name", module.cluster.cluster_name]
    command     = "aws"
  }
}
```

## Nodegroup
The nodegroup module is responsible for creating EKS worker node groups. It creates worker nodes as autoscaling groups and supports various other configuration options which can be found in the nodegroup module's README

## IRSA_Role
The irsa_role module is responsible for creating IAM roles that are integrated with cluster service accounts.

## Differences to cmdlabs/terraform-aws-eks
- Only 'native' EKS features are implemented. This means no KIAM support.
- Nodegroups are now handled through the use of a submodule. This simplifies module development and providers much nicer error messages to users
- Proxy Support
- AWS Auth configmap is now managed by the cluster module allowing an EKS cluster to be deployed with a single command (Note: This is discouraged by the Kubernetes Terraform provider, but does seem to work)
