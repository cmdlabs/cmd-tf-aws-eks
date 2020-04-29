resource "aws_security_group" "cluster_api" {
  # As of platform 1.14 eks3 this security group is no longer used for node->controlplane communication
  # It is only used for additional endpoints accessing a private api endpoint. 
  # https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html
  name        = "eks-${var.cluster_name}-cluster"
  description = "EKS Cluster ENI"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "additional_sg_ingress" {
  count                    = length(var.cluster_access_additional_sg)
  security_group_id        = aws_security_group.cluster_api.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = var.cluster_access_additional_sg[count.index]
}

resource "aws_security_group_rule" "additional_ip_ingress" {
  count             = length(var.cluster_access_additional_ip) > 0 ? 1 : 0
  security_group_id = aws_security_group.cluster_api.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.cluster_access_additional_ip
}
