# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.0] 2020-09-03
### Breaking
- For existing clusters it is necessary to import the Cluster CloudWatch Log Group into the Terraform state eg. `terraform import module.<module_name>.aws_cloudwatch_log_group.main /aws/eks/<cluster_name>/cluster`

### Added
- Cluster CloudWatch Log Group resource

## [0.3.0] 2020-09-01
### Breaking
- upgraded required_providers format to Terraform 0.13 (compatible with Terraform >= 0.12.26)

## [0.2.1] 2020-06-12
### Fix
- disable kms alias creation when eks encryption is disabled

## [0.2.0] 2020-04-27
### Breaking
- This module no longer supports EKS 1.13 due to the security group changes required to support managed nodes/fargate.
- Nodegroups no longer create their own security groups. The node security group is centrally managed and created automatically by the EKS cluster now. The old cluster security group is now only used for controlling access to the private EKS endpoint. See https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html for more information

### Added
- EKS Fargate support
- IRSA roles now support tags

## [0.1.0] 2020-04-24
- Initial release
