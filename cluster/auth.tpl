- rolearn: ${nodes_role_arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
%{ for role in roles ~}
- rolearn: ${role.rolearn}
  username: ${role.username}
%{ if role.groups != null ~}
  groups:
%{ for group in role.groups ~}
    - ${group}
%{ endfor ~}
%{ endif ~}
%{ endfor ~}
