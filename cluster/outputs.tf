output "cluster_name" {
  value = aws_eks_cluster.main.id
}

output "cluster_version" {
  value = aws_eks_cluster.main.version
}

output "cluster_arn" {
  value = aws_eks_cluster.main.arn
}

output "control_plane_endpoint" {
  description = "Kubernetes Cluster API Endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "control_plane_security_group" {
  description = "Kubernetes Cluster Control Plane Security Group - Used for nodes to communicate"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "control_plane_api_security_group" {
  description = "Kubernetes Cluster API Security Group - Used for access to the private EKS endpoint"
  value       = aws_security_group.cluster_api.id
}

output "control_plane_certificate_authority" {
  description = "Cluster Certificate Authority Certificate"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_openid_connect_provider_arn" {
  description = "Kubernetes Cluster OpenID Connect ARN"
  value       = aws_iam_openid_connect_provider.main.arn
}

output "cluster_openid_connect_provider_url" {
  description = "Kubernetes Cluster OpenID Connect URL"
  value       = aws_iam_openid_connect_provider.main.url
}

output "cluster_node_iam_role_arn" {
  description = "IAM role that allows nodes to join the cluster"
  value       = aws_iam_role.nodes.arn
}

output "cluster_node_iam_role" {
  description = "IAM role that allows nodes to join the cluster"
  value       = aws_iam_role.nodes.name
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer url for use in creating OIDC providers"
  value       = aws_eks_cluster.main.identity.0.oidc.0.issuer
}

output "cluster_oidc_issuer_thumbprint" {
  description = "OIDC issuer thumbprint for use in creating OIDC providers"
  value       = aws_iam_openid_connect_provider.main.thumbprint_list
}

output "vpc_id" {
  description = "VPC ID for EKS Cluster"
  value       = var.vpc_id
}

output "private_subnets" {
  description = "Private tier subnet list"
  value       = var.private_subnets
}

output "public_subnets" {
  description = "Public tier subnet list"
  value       = var.public_subnets
}

output "pod_execution_role_arn" {
  description = "IAM role Fargate nodes will use to join the cluster"
  value       = aws_iam_role.fargate.arn
}
