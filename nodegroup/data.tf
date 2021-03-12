data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.nodegroup_version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

data "template_file" "launch_template_userdata" {
  template = file("${path.module}/userdata.sh.tpl")

  vars = {
    cluster_name       = var.cluster_name
    pre_userdata       = var.pre_userdata
    post_userdata      = var.post_userdata
    kubelet_extra_args = var.kubelet_extra_args
    http_proxy         = var.http_proxy
    proxy_bypass       = var.proxy_bypass
  }
}
