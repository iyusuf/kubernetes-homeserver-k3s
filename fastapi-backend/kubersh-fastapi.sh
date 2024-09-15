
docker build -t fastapi-backend -f Dockerfile .
docker tag fastapi-backend iyusuf/fastapi-backend:latest
docker push iyusuf/fastapi-backend:latest

# Apply the kubernetes deployment
kubectl apply -f deployment.yaml

kubectl rollout restart deployment fastapi-backend -n tinyweb3tier



# To update pod with newer container image
## First find the deployment name
kubectl get deployments.apps -n tinyweb3tier 
## Then restart the deployment
kubectl rollout restart deployment fastapi-backend -n tinyweb3tier


kubectl set image deployment/fastapi-backend fastapi=iyusuf/fastapi-backend -n tinyweb3tier

kubectl rollout restart deployment fastapi-backend -n tinyweb3tier


# Run uvicorn
uvicorn app.main:app --reload  --host 0.0.0.0 --port 8000