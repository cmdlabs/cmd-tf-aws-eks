module "vpc" {
  source = "github.com/cmdlabs/cmd-tf-aws-vpc?ref=0.7.0"

  vpc_name                  = "eks-ci-test"
  vpc_cidr_block            = "10.13.0.0/16"
  availability_zones        = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  enable_per_az_nat_gateway = false
}

module "cluster" {
  source = "../cluster"

  cluster_name    = "eks-ci-test"
  cluster_version = "1.15"

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_tier_subnet_ids
  public_subnets  = module.vpc.public_tier_subnet_ids

  autotag_subnets       = true
  autotag_profile       = "cmdlabtf-master"
  manage_aws_auth       = true
  enable_eks_encryption = true

  auth_roles = [{
    rolearn  = "arn:aws:iam::471871437096:role/cmdlabtf-role-console-breakglass"
    username = "cmdlabtf-role-console-breakglass"
    groups   = ["system:masters"]
  }]

  tags = {
    Owner = "CMD"
  }
}

module "nodegroup1" {
  source = "../nodegroup"

  cluster_name      = module.cluster.cluster_name
  nodegroup_name    = "nodegroup1"
  nodegroup_version = module.cluster.cluster_version

  vpc_id      = module.cluster.vpc_id
  vpc_subnets = module.cluster.private_subnets

  instance_types       = ["t3.medium"]
  asg_desired_capacity = 1

  iam_role_name                = module.cluster.cluster_node_iam_role
  control_plane_security_group = module.cluster.control_plane_security_group

  tags = {
    Owner = "CMD"
  }
}

module "role1" {
  source = "../irsa_role"

  role_name         = "testrole"
  cluster_name      = module.cluster.cluster_name
  namespace         = "default"
  service_account   = "default"
  oidc_provider_arn = module.cluster.cluster_openid_connect_provider_arn
  oidc_provider_url = module.cluster.cluster_openid_connect_provider_url

  policies = [
    {
      actions   = ["route53:GetChange"]
      resources = ["arn:aws:route53:::change/*"]
    },
    {
      actions   = ["route53:ListHostedZonesByName"]
      resources = ["*"]
    },
    {
      actions = [
        "route53:ChangeResourceRecordSets",
        "route53:ListResourceRecordSets"
      ]
      resources = ["arn:aws:route53:::hostedzone/*"]
    }
  ]
}
