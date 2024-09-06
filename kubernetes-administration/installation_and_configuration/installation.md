# Install k3s
## Read 

- [Quick Setup](https://www.devopsschool.com/blog/a-basic-k3s-tutorial-for-kubernetes/)

- [Setup lightweight Kubernetes with K3s](https://pgillich.medium.com/setup-lightweight-kubernetes-with-k3s-6a1c57d62217)

## Config.

-- **Configuration for DEVELOPMENT ONLY setup**
Sample config only for a development laptops [LINK](https://0to1.nl/post/k3s-kubectl-permission/)

```bash
    # Disable ufw
    systemctl disable firewalld --now

    # Install k3s from script
    sudo curl -sfL https://get.k3s.io | sh -

    # Verify install
    sudo k3s kubectl get nodes

    # Configure
    sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config 
    chown $USER ~/.kube/config 
    chmod 600 ~/.kube/config 

    export KUBECONFIG=~/.kube/config # Ad this line to .bashrc if you want

    # Consider this only, only if it will be used 100% for development
    sudo chmod 644 /etc/rancher/k3s/k3s.yaml
    ## You will need to run this every time you boot your laptop.
```

# Install kubectl command completion script if you haven't already.
