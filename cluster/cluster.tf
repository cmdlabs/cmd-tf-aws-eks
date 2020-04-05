resource "aws_eks_cluster" "main" {
  name    = var.cluster_name
  version = var.cluster_version

  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.cluster.id]
    subnet_ids         = var.private_subnets

    endpoint_private_access = var.cluster_endpoint_private
    endpoint_public_access  = var.cluster_endpoint_public
    public_access_cidrs     = var.public_access_cidrs
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
  ]
}

resource "aws_iam_openid_connect_provider" "main" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"] # Thumbprint is static for the life of the root ca
  url             = aws_eks_cluster.main.identity.0.oidc.0.issuer
}
