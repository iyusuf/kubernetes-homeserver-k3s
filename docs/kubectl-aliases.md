# [The Guide to Pass the CKAD Exam](https://hackernoon.com/the-only-guide-you-need-to-pass-the-ckad-certified-kubernetes-application-developer-exam)


## Examples of useful aliases:


```bash
alias k=kubectl
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kdp='kubectl describe pod'
alias kds='kubectl describe svc'
alias kaf='kubectl apply -f'
alias kcf='kubectl create -f'

alias do="--dry-run=client -o yaml"
alias now="--force --grace-period 0"

# for context/namespace switching
alias kx='kubectl config use-context'
alias kn='kubectl config set-context --current --namespace'
```

## Examples of using the aliases:

```bash
# Apply a configuration from a YAML file
kaf my-config.yaml

# Create resources from a YAML file
kcf my-resources.yaml 

# Generate the YAML for a new pod without creating it
k run nginx --image=nginx $do 

# Force delete a pod immediately
k delete pod nginx $now 

# Generate the YAML for a new deployment without creating it
k create deployment my-deployment --image=nginx $do 

# Force delete a deployment immediately
k delete deployment my-deployment $now 

# Switch context quickly
kx new-context 

# Switch namespace quickly
kn new-namespace 
```

## Use Imperative Commands: Whenever possible, use imperative commands to achieve tasks quickly. For example:

```bash
# create a namespace
k create namespace {ns} 

# run a pod
k run nginx --image=nginx --restart=Never -n {ns} 

# expose a pod
k expose pod nginx --port=80 --target-port=80 -n {ns} 

# set an image on a deployment
k set image deployment/nginx nginx=nginx:latest -n {ns} 

# create a deployment
k create deployment nginx --image=nginx 

#scale a deployment
k scale deployment nginx --replicas=3 

# create a config map
k create configmap my-config --from-literal=key1=value1 

# create a secret
k create secret generic my-secret --from-literal=password=12345 
```