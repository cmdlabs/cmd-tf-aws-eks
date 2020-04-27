variable "fargate_profile_name" {
  description = "Fargate Profile Name"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster the fargate profile will be used with"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private tier subnet list"
  type        = list(string)
}

variable "pod_execution_role_arn" {
  description = "IAM role Fargate nodes will use to join the cluster"
  type        = string
}

variable "selectors" {
  description = "A map of namespaces and labels that is used to select which pods run on Fargate"
  type = list(object({
    namespace = string
    labels    = map(string)
  }))
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
  default     = {}
}
