kubectl delete namespaces --all --ignore-not-found=true --field-selector metadata.name!=kube-system,metadata.name!=kube-public,metadata.name!=default
kubectl delete all --all -n default
kubectl delete pv --all
kubectl delete clusterroles --all
kubectl delete clusterrolebindings --all
kubectl get all --all-namespaces
