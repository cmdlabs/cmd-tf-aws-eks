variable "cluster_name" {
  description = "Name of the EKS Cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS Cluster Version"
  type        = string
}

variable "cluster_endpoint_private" {
  description = "Enable Amazon EKS private API server endpoint."
  default     = false
}

variable "cluster_endpoint_public" {
  description = "Enable Amazon EKS public API server endpoint."
  default     = true
}

variable "private_subnets" {
  description = "Private tier subnet list"
  type        = list(string)
}

variable "public_access_cidrs" {
  description = "Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled"
  default     = ["0.0.0.0/0"]
  type        = list(string)
}

variable "public_subnets" {
  description = "Public tier subnet list"
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "A list of the desired control plane logging to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "cluster_access_additional_sg" {
  description = "A list of additional security groups that are allowed access to the API server"
  type        = list(string)
  default     = []
}

variable "cluster_access_additional_ip" {
  description = "A list of additional ip ranges that are allowed access to the API server"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC ID for EKS Cluster"
  type        = string
}

variable "autotag_subnets" {
  description = "Automatically add Kubernetes tags to subnets. Requires aws-cli to be available."
  type        = bool
  default     = false
}

variable "enable_ecr" {
  description = "Grant AmazonEC2ContainerRegistryReadOnly permissions to worker nodes"
  type        = bool
  default     = true
}

variable "enable_ssm" {
  description = "Grant AmazonSSMManagedInstanceCore permissions to worker nodes"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
  default     = {}
}

variable "autotag_profile" {
  description = "Defines an optional AWS profile to use with aws-cli when auto-tagging subnets"
  type        = string
  default     = ""
}

variable "auth_roles" {
  description = "Additional IAM Roles to add to the aws-auth configmap"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "manage_aws_auth" {
  description = "Create aws-auth configmap. This requires curl to be available locally as a null_resource is used to check if the API Server is ready"
  type        = bool
  default     = false
}


variable "enable_eks_encryption" {
  description = "Enable EKS encryption provider for secrets"
  type        = bool
  default     = false
}

