resource "kubernetes_config_map" "aws_auth" {
  count = var.manage_aws_auth ? 1 : 0

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

  depends_on = [
    null_resource.wait_for_cluster
  ]
}

resource "null_resource" "wait_for_cluster" {
  count = var.manage_aws_auth ? 1 : 0

  provisioner "local-exec" {
    command     = "echo Waiting for API Server endpoint...;for i in `seq 1 20`; do curl -k -s -m 15 $ENDPOINT/healthz && exit 0 || true; sleep 5; done; echo Failed waiting for API Server endpoint && exit 1"
    environment = {
      ENDPOINT = aws_eks_cluster.main.endpoint
    }
  }

  depends_on = [
    aws_eks_cluster.main,
    aws_security_group_rule.additional_sg_ingress,
    aws_security_group_rule.additional_ip_ingress
  ]
}
