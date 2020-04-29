## Providers

The following providers are used by this module:

- aws (>= 2.55.0)

## Required Inputs

The following input variables are required:

### cluster\_name

Description: EKS Cluster the fargate profile will be used with

Type: `string`

### fargate\_profile\_name

Description: Fargate Profile Name

Type: `string`

### pod\_execution\_role\_arn

Description: IAM role Fargate nodes will use to join the cluster

Type: `string`

### private\_subnet\_ids

Description: Private tier subnet list

Type: `list(string)`

### selectors

Description: A map of namespaces and labels that is used to select which pods run on Fargate

Type:

```hcl
list(object({
    namespace = string
    labels    = map(string)
  }))
```

## Optional Inputs

The following input variables are optional (have default values):

### tags

Description: Tags to apply to created resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### fargate\_profile\_arn

Description: n/a

