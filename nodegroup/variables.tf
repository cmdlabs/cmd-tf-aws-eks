variable "control_plane_security_group" {
  description = "ID of the existing control plane security group. Can be found in the outputs of the cluster module."
  type        = string
}

variable "nodegroup_name" {
  description = "Name to be used as a prefix for all resources in a nodegroup. Must be unique in an AWS accounts."
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS Cluster to join"
  type        = string
}

variable "nodegroup_version" {
  description = "Node Group Kubernetes Version"
  type        = string
}

variable "asg_per_subnet" {
  description = "Create ASG for each VPC subnet"
  type        = bool
  default     = true
}

variable "asg_desired_capacity" {
  description = "ASG desired capacity. Ignored after creation"
  type        = number
  default     = 0
}

variable "asg_min_size" {
  description = "ASG Minimum Capacity"
  type        = number
  default     = 0
}

variable "asg_max_size" {
  description = "ASG Maximum Capacity"
  type        = number
  default     = 10
}

variable "vpc_subnets" {
  description = "A list of subnets for the ASG to place instances in"
  type        = list(string)
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the worker group"
  type        = list(string)
  default     = null
}

variable "enabled_metrics" {
  description = "A list of ASG metrics to enable"
  type        = list(string)
  default     = null
}

variable "on_demand_allocation_strategy" {
  description = "Strategy to use when launching on-demand instances"
  type        = string
  default     = "prioritized"
}

variable "on_demand_base_capacity" {
  description = "Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances"
  type        = number
  default     = 0
}

variable "on_demand_percentage_above_base_capacity" {
  description = "Percentage split between on-demand and spot instances above the base on-demand capacity"
  type        = number
  default     = 0
}

variable "spot_allocation_strategy" {
  description = "How to allocate capacity across the Spot pools"
  type        = string
  default     = "lowest-price"
}

variable "spot_instance_pools" {
  description = "Number of Spot pools per availability zone to allocate capacity"
  type        = number
  default     = 10
}

variable "spot_max_price" {
  description = "Maximum price youre willing to pay for spot instances. Defaults to the on demand price if blank"
  type        = string
  default     = ""
}

variable "pre_userdata" {
  description = "Userdata to prepend to the standard userdata"
  type        = string
  default     = ""
}

variable "post_userdata" {
  description = "Userdata to append to the standard userdata"
  type        = string
  default     = ""
}

variable "kubelet_extra_args" {
  description = "Additional arguments to pass to the kubelet"
  type        = string
  default     = ""
}

variable "instance_types" {
  description = "Instance types used in the ASG"
  type        = list(string)
  default     = ["m5.large", "m4.large"]
}

variable "autoscaling_enabled" {
  description = "Allows cluster-autoscaler to manage this ASG"
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "IAM Role to allow nodes to join the cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for EKS Cluster"
  type        = string
}

variable "root_volume_size" {
  description = "Root EBS volume size"
  type        = number
  default     = 100
}

variable "detailed_monitoring" {
  description = "Enable EC2 detailed monitoring"
  type        = bool
  default     = false
}

variable "ami_id" {
  description = "Override Nodegroup AMI ID"
  type        = string
  default     = ""
}

variable "http_proxy" {
  description = "HTTP proxy to use during node bootstrap. http://<ip>:<port>"
  type        = string
  default     = ""
}

variable "proxy_bypass" {
  description = "A comma separated string of URL Suffixes/IP Addresses that will not go via the http_proxy"
  type        = string
  default     = "169.254.169.254,.eks.amazonaws.com"
}

variable "create_schedule" {
  type        = bool
  description = "Schedule shutdown and startup of ASG instances"
  default     = false
}

variable "scheduled_shutdown" {
  description = "Scheduled shutdown of ASG instances in UTC"
  type        = string
  default     = "00 09 * * MON-FRI" # 7pm Mon-Fri AEST
}

variable "scheduled_startup" {
  description = "Scheduled startup of ASG instances in UTC"
  type        = string
  default     = "00 21 * * SUN-THU" # 7am Mon-Fri AEST
}

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
  default     = {}
}
