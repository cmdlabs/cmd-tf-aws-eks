resource "aws_eks_cluster" "main" {
  name    = var.cluster_name
  version = var.cluster_version

  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.cluster_api.id]
    subnet_ids         = var.private_subnets

    endpoint_private_access = var.cluster_endpoint_private
    endpoint_public_access  = var.cluster_endpoint_public
    public_access_cidrs     = var.public_access_cidrs
  }

  dynamic encryption_config {
    for_each = var.enable_eks_encryption ? [1] : [] # Only include this block if var.enable_eks_encryption==true

    content {
      provider {
        key_arn = aws_kms_key.k8s_master_key[0].arn
      }
      resources = ["secrets"]
    }
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  tags = var.tags

  depends_on = [
    aws_cloudwatch_log_group.main,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
  ]
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.cluster_log_retention
  tags              = var.tags
}

resource "aws_iam_openid_connect_provider" "main" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"] # Thumbprint is static for the life of the root ca
  url             = aws_eks_cluster.main.identity.0.oidc.0.issuer
}

resource "aws_kms_key" "k8s_master_key" {
  count = var.enable_eks_encryption ? 1 : 0
}

resource "aws_kms_alias" "k8s_master_key" {
  count         = var.enable_eks_encryption ? 1 : 0
  name          = "alias/eks/${var.cluster_name}"
  target_key_id = aws_kms_key.k8s_master_key[0].key_id
}
