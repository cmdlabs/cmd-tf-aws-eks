## Requirements

The following requirements are needed by this module:

- terraform ( >= 0.14.6)

- aws (>= 3.76.1)

- null (>= 2.1.2)

- template (>= 2.1)

## Providers

The following providers are used by this module:

- aws (>= 3.76.1)

- template (>= 2.1)

## Required Inputs

The following input variables are required:

### cluster\_name

Description: Name of the EKS Cluster to join

Type: `string`

### control\_plane\_security\_group

Description: ID of the existing control plane security group. Can be found in the outputs of the cluster module.

Type: `string`

### iam\_role\_name

Description: IAM Role to allow nodes to join the cluster

Type: `string`

### nodegroup\_name

Description: Name to be used as a prefix for all resources in a nodegroup. Must be unique in an AWS accounts.

Type: `string`

### nodegroup\_version

Description: Node Group Kubernetes Version

Type: `string`

### vpc\_id

Description: VPC ID for EKS Cluster

Type: `string`

### vpc\_subnets

Description: A list of subnets for the ASG to place instances in

Type: `list(string)`

## Optional Inputs

The following input variables are optional (have default values):

### ami\_id

Description: Override Nodegroup AMI ID

Type: `string`

Default: `""`

### asg\_desired\_capacity

Description: ASG desired capacity. Ignored after creation

Type: `number`

Default: `0`

### asg\_max\_size

Description: ASG Maximum Capacity

Type: `number`

Default: `10`

### asg\_min\_size

Description: ASG Minimum Capacity

Type: `number`

Default: `0`

### asg\_per\_subnet

Description: Create ASG for each VPC subnet

Type: `bool`

Default: `true`

### autoscaling\_enabled

Description: Allows cluster-autoscaler to manage this ASG

Type: `bool`

Default: `true`

### detailed\_monitoring

Description: Enable EC2 detailed monitoring

Type: `bool`

Default: `false`

### enabled\_metrics

Description: A list of ASG metrics to enable

Type: `list(string)`

Default: `null`

### http\_proxy

Description: HTTP proxy to use during node bootstrap. http://<ip>:<port>

Type: `string`

Default: `""`

### instance\_types

Description: Instance types used in the ASG

Type: `list(string)`

Default:

```json
[
  "m5.large",
  "m4.large"
]
```

### kubelet\_extra\_args

Description: Additional arguments to pass to the kubelet

Type: `string`

Default: `""`

### on\_demand\_allocation\_strategy

Description: Strategy to use when launching on-demand instances

Type: `string`

Default: `"prioritized"`

### on\_demand\_base\_capacity

Description: Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances

Type: `number`

Default: `0`

### on\_demand\_percentage\_above\_base\_capacity

Description: Percentage split between on-demand and spot instances above the base on-demand capacity

Type: `number`

Default: `0`

### post\_userdata

Description: Userdata to append to the standard userdata

Type: `string`

Default: `""`

### pre\_userdata

Description: Userdata to prepend to the standard userdata

Type: `string`

Default: `""`

### proxy\_bypass

Description: A comma separated string of URL Suffixes/IP Addresses that will not go via the http\_proxy

Type: `string`

Default: `"169.254.169.254,.eks.amazonaws.com"`

### root\_volume\_size

Description: Root EBS volume size

Type: `number`

Default: `100`

### root\_volume\_type

Description: EBS Root Volume Type gp2, gp3, io1, io2. Default is gp2

Type: `string`

Default: `gp2`

### root\_volume\_delete\_on\_termination

Description: EBS Root volume delete on termination. Default is true

Type: `bool`

Default: `true`

### root\_volume\_volume\_encrypted

Description: EBS Root volume is encrypted using KMS. Default is true

Type: `bool`

Default: `true`

### root\_ebs\_kms\_key\_id

Description: CMK KMS Key ID for defined EBS Root volume. Default is none will use AWS/EBS KMS Key Id if root_volume_encrypted is true (default

Type: `string`

Default: `""`

### root\_volume\_snapshot\_id

Description: EBS Root Volume will be based off desired Snapshot ID if defined. Default is null (none) for compatability.

Type: `string`

Default: `""`

### root\_volume\_volume\_throughput

Description: EBS Root Volume throughput in MiB/s if gp3 type up to 1000MiB/s. Default is null (none) as defalt volume type is still gp2 for compatability.

Type: `string`

Default: `""`

### spot\_allocation\_strategy

Description: How to allocate capacity across the Spot pools

Type: `string`

Default: `"lowest-price"`

### spot\_instance\_pools

Description: Number of Spot pools per availability zone to allocate capacity

Type: `number`

Default: `10`

### spot\_max\_price

Description: Maximum price youre willing to pay for spot instances. Defaults to the on demand price if blank

Type: `string`

Default: `""`

### suspended\_processes

Description: A list of processes to suspend for the worker group

Type: `list(string)`

Default: `null`

### tags

Description: Tags to apply to created resources

Type: `map(string)`

Default: `{}`

## Outputs

No output.

