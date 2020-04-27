resource "aws_eks_fargate_profile" "main" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = var.pod_execution_role_arn
  subnet_ids             = var.private_subnet_ids

  dynamic selector {
    for_each = var.selectors

    content {
      namespace = selector.value.namespace
      labels = selector.value.labels
    }
  }

  tags = var.tags
}
