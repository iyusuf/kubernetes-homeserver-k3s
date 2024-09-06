
docker build -t fastapi-backend -f Dockerfile .
docker tag fastapi-backend iyusuf/fastapi-backend:latest
docker push iyusuf/fastapi-backend:latest

# Apply the kubernetes deployment
kubectl apply -f deployment.yaml

kubectl rollout restart deployment fastapi-backend -n barebone-html



# To update pod with newer container image
## First find the deployment name
kubectl get deployments.apps -n barebone-html 
## Then restart the deployment
kubectl rollout restart deployment fastapi-backend -n barebone-html


kubectl set image deployment/fastapi-backend fastapi=iyusuf/fastapi-backend -n barebone-html

kubectl rollout restart deployment fastapi-backend -n barebone-html


# Run uvicorn
uvicorn app.main:app --reload  --host 0.0.0.0 --port 8000