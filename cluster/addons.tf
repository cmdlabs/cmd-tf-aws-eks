resource "aws_eks_addon" "coredns" {
  count         = var.enable_addon_coredns ? 1 : 0
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "coredns"
  addon_version = var.addon_coredns_version
}

resource "aws_eks_addon" "kubeproxy" {
  count         = var.enable_addon_kubeproxy ? 1 : 0
  cluster_name  = aws_eks_cluster.main.name
  addon_name    = "kube-proxy"
  addon_version = var.addon_kubeproxy_version

}
