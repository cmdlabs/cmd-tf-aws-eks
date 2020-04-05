resource "aws_security_group" "nodes" {
  name        = "eks-${var.cluster_name}-nodes-${var.nodegroup_name}"
  description = "Security group for worker nodes of cluster ${var.cluster_name}"
  vpc_id      = var.vpc_id

  tags = merge({
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    },
    var.tags
  )
}

resource "aws_security_group_rule" "node_to_node" {
  security_group_id = aws_security_group.nodes.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}

resource "aws_security_group_rule" "node_to_internet" {
  security_group_id = aws_security_group.nodes.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "control_plane_to_node_proxy" {
  # Full port range to allow kubectl proxy
  security_group_id        = aws_security_group.nodes.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.control_plane_security_group
}

resource "aws_security_group_rule" "node_to_controlplane" {
  security_group_id        = var.control_plane_security_group
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nodes.id
}

resource "aws_security_group_rule" "control_plane_to_node" {
  security_group_id        = var.control_plane_security_group
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nodes.id
}
