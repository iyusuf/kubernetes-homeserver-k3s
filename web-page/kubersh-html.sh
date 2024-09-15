#Web server 1 deployment
docker build -t web-server1-image -f Dockerfile .
docker tag web-server1-image iyusuf/web-server1-image:latest
docker push iyusuf/web-server1-image:latest

# Deploy to Kubernetes
kubectl apply -f deployment.yaml

# If you need to update container in the pod
kubectl rollout restart deployment web-server1 -n tinyweb3tier



# To update pod with newer container image
## First find the deployment name
kubectl get deployments.apps -n tinyweb3tier 
## Then restart the deployment
kubectl rollout restart deployment web-server2 -n tinyweb3tier



