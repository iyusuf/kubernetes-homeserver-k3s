# Some commons Docker and Kubernetes commands


## PY Backend

### Docker works

- Docker build
docker build -t iyusuf/py-backend -f Dockerfile .
- Docker Tag
docker tag iyusuf/py-backend iyusuf/py-backend:v1
- Docker run to test locally
docker run -d -p 8000:8000 --name pyb iyusuf/py-backend:v1

- If test is successful, push it to docker hub
docker push iyusuf/py-backend:v1


### Kubernetes work

- Apply the kubernetes deployment
kubectl apply -f Backend-Deployment-Service.yaml


## JS Frontend

- Docker build
docker build -t iyusuf/js-frontend -f Dockerfile .
- Docker Tag
docker tag iyusuf/js-frontend iyusuf/js-frontend:v1
- Docker run to test locally
docker run -d -p 80:80 --name jsf iyusuf/js-frontend:v1

- 
kubectl rollout restart deployment web-server2 -n barebone-html






## To redeploy a pod

kubectl rollout restart deployment <<deployment name>> -n <<name space>>
kubectl rollout restart deployment py-backend -n samehost-3tier


## Trouble shoot ErrImagePull

- First get all from name space
 kubectl get all -n samehost-3tier

kubectl describe pod py-backend-5b9d4fd74d-nw7br -n samehost-3tier


## Delete a specific resources
kubectl delete deployment fastapi-backend -n samehost-3tier
kubectl delete service fastapi-backend -n samehost-3tier
kubectl delete all -l app=fastapi-backend -n samehost-3tier




### Kubernetes Delete

kubectl delete namespaces --all --ignore-not-found=true --field-selector metadata.name!=kube-system,metadata.name!=kube-public,metadata.name!=default
kubectl delete all --all -n default
kubectl delete pv --all
kubectl delete clusterroles --all
kubectl delete clusterrolebindings --all
kubectl get all --all-namespaces

### Kubernetes Get

kubectl get pods --all-namespaces
kubectl get services --all-namespaces
kubectl get deployments --all-namespaces
kubectl get ingress --all-namespaces
kubectl get configmaps --all-namespaces
kubectl get secrets --all-namespaces
kubectl get pvc --all-namespaces
