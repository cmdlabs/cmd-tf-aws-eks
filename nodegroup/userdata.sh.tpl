#!/bin/bash -xe

# Allow user supplied pre userdata code
${pre_userdata}

# Configure proxy for Userdata
%{ if http_proxy != null ~}
export http_proxy=${http_proxy}
export https_proxy=${http_proxy}
export no_proxy=${proxy_bypass}

# Configure proxy for ssm/kubelet/docker
mkdir -p /etc/systemd/system/amazon-ssm-agent.service.d/
echo "[Service]
Environment="http_proxy=${http_proxy}"
Environment="https_proxy=${http_proxy}"
Environment="no_proxy=${proxy_bypass}"
" > /etc/systemd/system/amazon-ssm-agent.service.d/override.conf

mkdir -p /etc/systemd/system/kubelet.service.d/
echo "[Service]
Environment="http_proxy=${http_proxy}"
Environment="https_proxy=${http_proxy}"
Environment="no_proxy=${proxy_bypass}"
" > /etc/systemd/system/kubelet.service.d/0-http-proxy.conf

mkdir -p /etc/systemd/system/docker.service.d/
echo "[Service]
Environment="http_proxy=${http_proxy}"
Environment="https_proxy=${http_proxy}"
Environment="no_proxy=${proxy_bypass}"
" > /etc/systemd/system/docker.service.d/0-http-proxy.conf
%{ endif ~}

# Install SSM Agent
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl daemon-reload
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

systemctl daemon-reload
systemctl restart docker

# Bootstrap and join the cluster
/etc/eks/bootstrap.sh --kubelet-extra-args '${kubelet_extra_args}' '${cluster_name}'

# Allow user supplied userdata code
${post_userdata}
