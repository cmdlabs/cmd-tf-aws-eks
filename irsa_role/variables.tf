variable "role_name" {
  description = "IAM Role Name"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster the role will be used with"
  type        = string
}

variable "oidc_provider_arn" {
  description = "EKS Cluster OIDC Provider ARN"
  type        = string
}

variable "oidc_provider_url" {
  description = "EKS Cluster OIDC Provider URL"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace of the service account"
  type        = string
}

variable "service_account" {
  description = "Kubernetes service account name"
  type        = string
}

variable "policies" {
  description = "IAM policy attributes for IRSA roles"
  type = list(object({
    actions   = list(string)
    resources = list(string)
  }))
}
variable "conditional_policies" {
  description = "IAM policy attributes for IRSA policies with conditional statements"
  type = list(object({
    actions   = list(string)
    resources = list(string)
    effect    = string
    condition = any
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
  default     = {}
}
