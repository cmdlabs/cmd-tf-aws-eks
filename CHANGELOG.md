# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.7.1] 2021-09-17
### Added
   - added conditional statements to IRSA Roles

## [0.7.0] 2021-07-01
### Breaking
   - Updated nodegroup module to be compatible with terraform 1.0.0.  This is a breaking change for terraform versions less than 0.12.x, and has not been tested on versions earlier than 0.13.x.
### Changed
   - Updated nodegroup userdata script to ensure that amazon-ssm-agent is only attempted if it is not already installed.  This is necessary since [Amazon EKS AMI release v20210621](https://github.com/awslabs/amazon-eks-ami/blob/master/CHANGELOG.md#ami-release-v20210621).

## [0.6.0] 2021-06-29
### Changed
   - kube-proxy add-on deployment with default version matching EKS version
   - CoreDNS add-on deployment with default version matching EKS version
 
## [0.5.0] 2021-03-12
### Changed
- Implemented workaround to terraform bug that prevents the use of tags with computed values
- Uplift module tests to use Terraform 0.14, AWS Provider 3.x and Kubernetes Provider 2.x

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
