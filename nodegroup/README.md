## Requirements

The following requirements are needed by this module:

- terraform ( >= 0.12.26)

- aws (>= 2.55.0)

- null (>= 2.1.2)

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

### create\_schedule

Description: Schedule shutdown and startup of ASG instances

Type: `bool`

Default: `false`

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

### scheduled\_shutdown

Description: Scheduled shutdown of ASG instances in UTC

Type: `string`

Default: `"00 09 * * MON-FRI"`

### scheduled\_startup

Description: Scheduled startup of ASG instances in UTC

Type: `string`

Default: `"00 21 * * SUN-THU"`

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

