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

variable "root_volume_type" {
  description = "EBS Volume Type gps2, gps3, io1, io2. Default is gp2"
  type        = string
  default     = "gp2"
}

variable "root_volume_delete_on_termination" {
  description = "EBS Root volume delete on termination. Default is true"
  type        = bool
  default     = true
}

variable "root_volume_encrypted" {
  description = "EBS Root volume is encrypted using KMS. Default is true"
  type        = bool
  default     = true
}

variable "root_ebs_kms_key_id" {
  description = "CMK KMS Key ID for defined root volume. Default is none will use AWS/EBS KMS Key Id if root_volume_encrypted is true (default)."
  type        = string
  default     = ""
}

variable "root_volume_snapshot_id" {
  description = "EBS Root Volume will be based off desired Snapshot ID if defined. Default is null (none) for compatability."
  type        = string
  default     = ""
}

variable "root_volume_throughput" {
  description = "EBS Root Volume throughput in MiB/s if gp3 type up to 1000MiB/s. Default is null (none) as defalt volume type is still gp2 for compatability."
  type        = string
  default     = ""
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

variable "tags" {
  description = "Tags to apply to created resources"
  type        = map(string)
  default     = {}
}
