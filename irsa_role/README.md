## Providers

The following providers are used by this module:

- aws (>= 2.55.0)

## Required Inputs

The following input variables are required:

### cluster\_name

Description: EKS Cluster the role will be used with

Type: `string`

### namespace

Description: Kubernetes namespace of the service account

Type: `string`

### oidc\_provider\_arn

Description: EKS Cluster OIDC Provider ARN

Type: `string`

### oidc\_provider\_url

Description: EKS Cluster OIDC Provider URL

Type: `string`

### policies

Description: n/a

Type:

```hcl
list(object({
    actions = list(string)
    resources = list(string)
  }))
```

### role\_name

Description: IAM Role Name

Type: `string`

### service\_account

Description: Kubernetes service account name

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### tags

Description: Tags to apply to created resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### role\_arn

Description: n/a

