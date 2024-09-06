# Let's Encrypt + Kubernetes + CloudFlare [NOT WORKING]

Here's a step-by-step guide on how to expose your web application on port 32080 via CloudFlare and implement SSL using Let's Encrypt in your Kubernetes environment:

### Prerequisites:
1. **Kubernetes Cluster**: Ensure your Kubernetes cluster is up and running on your laptop.
2. **Domain Setup**: You have the domain `karmatech.us` managed by CloudFlare.
3. **kubectl Access**: Ensure you have access to the cluster using `kubectl`.
4. **Web Server Service** : You have Web Server service with nodeport exposed:
4. **Web Server Service** : You have Web Server service.

### Step 1: Configure CloudFlare for Your Domain
1. **Log in to CloudFlare** and add your domain `karmatech.us` if not already done.
2. **Update DNS Records**:
<<<<<<< HEAD
   - Add an `A` record pointing to your public IP (or the IP of your router if behind NAT) with the subdomain you want to use, for example, `app.karmatech.us`.
=======
   - Add an `A` record pointing to your public IP (or the IP of your router if behind NAT) with the subdomain you want to use, for example, `sslapptest.karmatech.us`.
>>>>>>> a48b89d7d69bd7eba4a93685a3a1c4ebe1a91d5b
   - Ensure the proxy status is enabled (orange cloud) for CloudFlare to handle SSL termination.

### Step 2: Install Cert-Manager in Kubernetes
Cert-Manager is a Kubernetes tool that automates the management and issuance of TLS certificates from various issuing sources, including Let's Encrypt.

1. **Install Cert-Manager**:
   ```bash
   kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.12.1/cert-manager.yaml
   ```

2. **Verify Installation**:
   ```bash
   kubectl get pods --namespace cert-manager
   ```

### Step 3: Configure DNS Challenge with CloudFlare
To use Let's Encrypt with CloudFlare, you need to set up a DNS challenge. This requires CloudFlare API tokens.

1. **Create a CloudFlare API Token**:
   - Go to the [CloudFlare dashboard](https://dash.cloudflare.com/profile/api-tokens).
   - Create a new API Token with the following permissions:
     - Zone:DNS:Edit (for your domain `karmatech.us`).
   - Save the token securely.

2. **Create a Kubernetes Secret for CloudFlare API Token**:
   ```bash
   kubectl create secret generic cloudflare-api-token-secret --from-literal=api-token=<YOUR_API_TOKEN>
   ```

### Step 4: Create Issuer or ClusterIssuer for Let's Encrypt
1. **Create a ClusterIssuer YAML file**:
   ```yaml
   apiVersion: cert-manager.io/v1
   kind: ClusterIssuer
   metadata:
     name: letsencrypt-cloudflare
   spec:
     acme:
       server: https://acme-v02.api.letsencrypt.org/directory
       email: your-email@domain.com
       privateKeySecretRef:
         name: letsencrypt-cloudflare
       solvers:
       - dns01:
           cloudflare:
             email: your-email@domain.com
             apiTokenSecretRef:
               name: cloudflare-api-token-secret
               key: api-token
   ```

2. **Apply the ClusterIssuer**:
   ```bash
   kubectl apply -f cluster-issuer.yaml
   ```

### Step 5: Create an Ingress Resource with TLS
You need to create an Ingress resource that routes traffic to your application and requests the TLS certificate using the `ClusterIssuer`.

1. **Create Ingress YAML file**:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: app-ingress
     annotations:
       cert-manager.io/cluster-issuer: "letsencrypt-cloudflare"
       nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
   spec:
     tls:
     - hosts:
       - app.karmatech.us
       secretName: app-tls
     rules:
     - host: app.karmatech.us
       http:
         paths:
         - path: /
           pathType: Prefix
           backend:
             service:
               name: your-service-name
               port:
                 number: 32080
   ```

2. **Apply the Ingress Resource**:
   ```bash
   kubectl apply -f ingress.yaml
   ```

### Step 6: Update CloudFlare SSL/TLS Settings
1. **Set SSL/TLS mode to "Full"** in your CloudFlare dashboard under the SSL/TLS settings for your domain.

### Step 7: Verify the Setup
1. **Check Certificate Issuance**:
   ```bash
   kubectl describe certificate app-tls
   ```
   Ensure the certificate is issued successfully.

2. **Test Your Application**:
   - Access `https://app.karmatech.us` in your browser.
   - Ensure the connection is secure and the SSL certificate is valid.

### Step 8: Monitor and Renew Certificates
Cert-Manager automatically renews the certificates before they expire. However, you can monitor them using Kubernetes resources.

This setup integrates Let's Encrypt with CloudFlare, ensuring your web application is exposed securely via HTTPS.