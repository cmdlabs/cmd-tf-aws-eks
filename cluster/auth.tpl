- groups:
    - system:bootstrappers
    - system:nodes
  rolearn: ${nodes_role_arn}
  username: system:node:{{EC2PrivateDNSName}}
- groups:
    - system:bootstrappers
    - system:nodes
    - system:node-proxier
  rolearn: ${fargate_role_arn}
  username: system:node:{{SessionName}}
%{ for role in roles ~}
%{ if role.groups != null ~}
- groups:
%{ for group in role.groups ~}
    - ${group}
  rolearn: ${role.rolearn}
  username: ${role.username}
%{ endfor ~}
%{ endif ~}
%{ endfor ~}
