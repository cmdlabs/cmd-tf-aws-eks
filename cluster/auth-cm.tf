resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = "${templatefile("${path.module}/auth.tpl", {
      nodes_role_arn = aws_iam_role.nodes.arn
      roles         = var.auth_roles
    })}"
  }
}
