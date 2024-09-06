# Install Docker

### Follow this document to install Docker in Ubuntu.
- [Official document](https://docs.docker.com/engine/install/ubuntu/)

### Install Docker Group and add user
- Add user to docker group

    ```bash
    sudo usermod -aG docker $USER
    newgrp docker
    docker images
    ```

# Install k3s
## Read "Quick Setup" to install K3s. 

- [Quick Setup](https://www.devopsschool.com/blog/a-basic-k3s-tutorial-for-kubernetes/)

- [ Optional ][Setup lightweight Kubernetes with K3s](https://pgillich.medium.com/setup-lightweight-kubernetes-with-k3s-6a1c57d62217)

## Configure K3s with your Ubuntu User for efficient use

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
    mkdir ~/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config 
    sudo chown $USER ~/.kube/config 
    sudo chmod 600 ~/.kube/config 

    export KUBECONFIG=~/.kube/config # Ad this line to .bashrc if you want

    # Consider this only, only if it will be used 100% for development
    sudo chmod 644 /etc/rancher/k3s/k3s.yaml
    ## You will need to run this every time you boot your laptop.
```

# Install kubectl and kubectl command completion script if you haven't already.

**[optional]** Task. 

**[Tutorial that worked on my Ubuntu 22 and 24](https://spacelift.io/blog/kubectl-auto-completion)**