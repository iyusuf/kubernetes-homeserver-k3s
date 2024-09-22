To get started with Helm and package your existing 3-tier application into Helm charts, follow these steps:

### 1. **Install Helm**
If Helm is not installed yet, you can install it by running:
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
Verify the installation:
```bash
helm version
```

### 2. **Create a Helm Chart**
Create a Helm chart for your application:
```bash
helm create myapp
```
This will create a basic directory structure for your Helm chart:
```
myapp/
  ├── Chart.yaml       # Metadata about the chart
  ├── values.yaml      # Default values for templates
  └── templates/       # Kubernetes manifests (deployments, services, etc.)
```

### 3. **Customize the Templates**
Now, move your existing YAML files (for deployment, services, etc.) into the `templates` directory. Helm templates allow you to inject values dynamically into your manifests using the values in `values.yaml`.

For example, take your existing FastAPI deployment YAML file and make it a template by adding placeholders:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.appName }}-backend
spec:
  replicas: {{ .Values.replicaCount }}
  template:
    spec:
      containers:
      - name: {{ .Values.containerName }}
        image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
```
In `values.yaml`:
```yaml
appName: fastapi-app
replicaCount: 3
containerName: fastapi-container
image:
  repository: fastapi-image
  tag: latest
```

### 4. **Adjust Your Frontend and Database Templates**
You can follow the same process for the frontend (Vue.js) and database (Postgres) components, creating a service and deployment template for each.

### 5. **Install and Test Your Chart**
Once you’ve created and customized your templates, install your Helm chart on your k3s cluster:
```bash
helm install myapp ./myapp
```

You can verify the deployment with:
```bash
kubectl get all
```

### 6. **Upgrade and Manage Your Helm Release**
You can upgrade your app using:
```bash
helm upgrade myapp ./myapp
```

To uninstall the release:
```bash
helm uninstall myapp
```

This will help you get started with Helm, packaging, and managing your 3-tier application in Kubernetes. Let me know if you need further details!