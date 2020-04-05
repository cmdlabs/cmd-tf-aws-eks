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
  description = "Kubernetes Cluster Control Plane Security Group"
  value       = aws_security_group.cluster.id
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
