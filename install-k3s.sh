#!/bin/bash

# Disable firewall (for development only)
sudo systemctl disable firewalld --now

# Install K3s
curl -sfL https://get.k3s.io | sh -

# Verify installation
sudo k3s kubectl get nodes

# Configure kubeconfig for the current user
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER ~/.kube/config
sudo chmod 600 ~/.kube/config

# Add KUBECONFIG to .bashrc
echo 'export KUBECONFIG=~/.kube/config' >> ~/.bashrc
source ~/.bashrc

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Enable kubectl command completion
echo 'source <(kubectl completion bash)' >> ~/.bashrc
source ~/.bashrc

# For zsh users
if [ -n "$ZSH_VERSION" ]; then
  echo 'source <(kubectl completion zsh)' >> ~/.zshrc
  source ~/.zshrc
fi

echo "K3s installation and configuration complete!"
