## Providers

The following providers are used by this module:

- aws (>= 2.55.0)

- kubernetes (>= 1.11.1)

- null (>= 2.1.2)

## Required Inputs

The following input variables are required:

### cluster\_name

Description: Name of the EKS Cluster

Type: `string`

### cluster\_version

Description: EKS Cluster Version

Type: `string`

### private\_subnets

Description: Private tier subnet list

Type: `list(string)`

### public\_subnets

Description: Public tier subnet list

Type: `list(string)`

### vpc\_id

Description: VPC ID for EKS Cluster

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### auth\_roles

Description: Additional IAM Roles to add to the aws-auth configmap

Type:

```hcl
list(object({
    rolearn = string
    username = string
    groups = list(string)
  }))
```

Default: `[]`

### autotag\_profile

Description: Defines an optional AWS profile to use with aws-cli when auto-tagging subnets

Type: `string`

Default: `""`

### autotag\_subnets

Description: Automatically add Kubernetes tags to subnets. Requires aws-cli to be available.

Type: `bool`

Default: `false`

### cluster\_access\_additional\_ip

Description: A list of additional ip ranges that are allowed access to the API server

Type: `list(string)`

Default: `[]`

### cluster\_access\_additional\_sg

Description: A list of additional security groups that are allowed access to the API server

Type: `list(string)`

Default: `[]`

### cluster\_endpoint\_private

Description: Enable Amazon EKS private API server endpoint.

Type: `bool`

Default: `false`

### cluster\_endpoint\_public

Description: Enable Amazon EKS public API server endpoint.

Type: `bool`

Default: `true`

### enable\_ecr

Description: Grant AmazonEC2ContainerRegistryReadOnly permissions to worker nodes

Type: `bool`

Default: `true`

### enable\_ssm

Description: Grant AmazonSSMManagedInstanceCore permissions to worker nodes

Type: `bool`

Default: `false`

### enabled\_cluster\_log\_types

Description: A list of the desired control plane logging to enable

Type: `list(string)`

Default:

```json
[
  "api",
  "audit",
  "authenticator",
  "controllerManager",
  "scheduler"
]
```

### public\_access\_cidrs

Description: Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled

Type: `list(string)`

Default:

```json
[
  "0.0.0.0/0"
]
```

### tags

Description: Tags to apply to created resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### cluster\_arn

Description: n/a

### cluster\_name

Description: n/a

### cluster\_node\_iam\_role

Description: IAM role that allows nodes to join the cluster

### cluster\_node\_iam\_role\_arn

Description: IAM role that allows nodes to join the cluster

### cluster\_oidc\_issuer\_thumbprint

Description: OIDC issuer thumbprint for use in creating OIDC providers

### cluster\_oidc\_issuer\_url

Description: OIDC issuer url for use in creating OIDC providers

### cluster\_openid\_connect\_provider\_arn

Description: Kubernetes Cluster OpenID Connect ARN

### cluster\_openid\_connect\_provider\_url

Description: Kubernetes Cluster OpenID Connect URL

### cluster\_version

Description: n/a

### control\_plane\_certificate\_authority

Description: Cluster Certificate Authority Certificate

### control\_plane\_endpoint

Description: Kubernetes Cluster API Endpoint

### control\_plane\_security\_group

Description: Kubernetes Cluster Control Plane Security Group

### vpc\_id

Description: VPC ID into which the EKS Cluster is deployed

### private\_subnets

Description: Private tier subnet list

### public\_subnets

Description: Public tier subnet list
