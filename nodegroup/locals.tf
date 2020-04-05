locals {
  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.eks_worker.id
}
