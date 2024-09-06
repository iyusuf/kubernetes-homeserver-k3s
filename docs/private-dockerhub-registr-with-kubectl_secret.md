## How to create and use secert to use a private repository

### Option 1

- First create a secret

kubectl create secret docker-registry docker-secret \
    --docker-server=https://index.docker.io/v1/ \
    --docker-username=iqbal.yusuf.dipu@outlook.com \
    --docker-password=************************ \
    --docker-email=iqbal.yusuf.dipu@outlook.com \
    --namespace=barebone-html


- Add the secret in deployment yaml.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pg-db
  namespace: barebone-html
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pg-db
  template:
    metadata:
      labels:
        app: pg-db
    spec:
      containers:
      - name: pg-db
        image: iyusuf/dbserver:latest
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_USER
          value: "myuser"
        - name: POSTGRES_PASSWORD
          value: "mypassword"
        - name: POSTGRES_DB
          value: "mydatabase"
      imagePullSecrets:
      - name: docker-secret
```


Option 2:

```bash
❯ cat ~/.docker/config.json 
{
        "auths": {
                "https://index.docker.io/v1/": {
                        "auth": "aXFiYWwueXVzdWYuZGlwdUBvdXRsb29rLmNvbTp0JTNGNnBzIWUvR2YyP18="
                }
        }
}
```
> cat ~/.docker/config.json | bas64

- take the output and use it in deployment file


- Create a deployment file of type Secret and apply

```yaml

apiVersion: v1
kind: Secret
metadata:
  name: docker-secret
  namespace: barebone-html
data:
  .dockerconfigjson: aXFiYWwueXVzdWYuZGlwdUBvdXRsb29rLmNvbTp0JTNGNnBzIWUvR2YyP18=
type: kubernetes.io/dockerconfigjson

```
