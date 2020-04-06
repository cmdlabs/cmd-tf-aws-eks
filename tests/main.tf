module "cluster" {
  source = "../cluster"

  cluster_name    = "cmdlab-sandpit1"
  cluster_version = "1.15"

  vpc_id          = "vpc-08aba235436a32ea1"
  private_subnets = ["subnet-0574e1ee9e5c0b2b6", "subnet-01a8bf5e8fd7d4272", "subnet-07b81e6ba3f185586"]
  public_subnets  = ["subnet-0bf82dc96b889af9c", "subnet-0aaf01629503bbc39", "subnet-0cbec076d958a1e78"]

  autotag_subnets = true
  manage_aws_auth = true

  auth_roles = [{
    rolearn  = "arn:aws:iam::722141136946:role/cmdlab-role-console-breakglass"
    username = "cmdlab-role-console-breakglass"
    groups   = ["system:masters"]
  }]

  tags = {
    Owner = "Dean"
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
    Owner = "Dean"
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
