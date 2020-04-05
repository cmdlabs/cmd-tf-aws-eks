resource "aws_security_group" "cluster" {
  name        = "eks-${var.cluster_name}-cluster"
  description = "EKS Cluster ENI"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "additional_sg_ingress" {
  count                    = length(var.cluster_access_additional_sg)
  security_group_id        = aws_security_group.cluster.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.cluster_access_additional_sg[count.index]
}

resource "aws_security_group_rule" "additional_ip_ingress" {
  count             = length(var.cluster_access_additional_ip) > 0 ? 1 : 0
  security_group_id = aws_security_group.cluster.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.cluster_access_additional_ip
}
