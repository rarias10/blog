#!/bin/bash

# Deploy Blog Microservices to Kops Cluster
set -e

# Check if AWS CLI is configured
if ! aws sts get-caller-identity &>/dev/null; then
    echo "❌ AWS CLI not configured. Please run 'aws configure' first."
    exit 1
fi

echo "🚀 Deploying Blog Microservices to Kops Cluster"

# Step 1: Create the cluster
echo "📦 Creating Kops cluster..."
kops create cluster --name=kubevpro.basquiat.app --state=s3://kopsstate1357 --zones=us-east-2a,us-east-2b --node-count=2 --node-size=t3.small --control-plane-size=t3.medium --dns-zone=kubevpro.basquiat.app --node-volume-size=12 --control-plane-volume-size=12 --ssh-public-key ~/.ssh/id_ed25519.pub

# Step 2: Update the cluster
echo "🔄 Updating cluster..."
kops update cluster --name kubevpro.basquiat.app --state=s3://kopsstate1357 --yes

# Step 3: Wait for cluster to be ready
echo "⏳ Waiting for cluster to be ready..."
kops validate cluster --name kubevpro.basquiat.app --state=s3://kopsstate1357 --wait 10m

# Step 4: Install NGINX Ingress Controller
echo "🌐 Installing NGINX Ingress Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml

# Wait for ingress controller to be ready
echo "⏳ Waiting for NGINX Ingress Controller..."
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=300s

# Step 5: Deploy the application
echo "🚀 Deploying blog application..."
kubectl apply -f infra/k8s/

# Step 6: Wait for deployments to be ready
echo "⏳ Waiting for deployments..."
kubectl wait --for=condition=available --timeout=300s deployment --all -n blog-app

# Step 7: Get LoadBalancer URL and update Route 53
echo "🔍 Getting LoadBalancer URL..."
LB_URL=$(kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "LoadBalancer URL: $LB_URL"

# Step 8: Update Route 53 DNS record
echo "🌐 Updating Route 53 DNS record..."
HOSTED_ZONE_ID=$(aws route53 list-hosted-zones-by-name --dns-name basquiat.app --query 'HostedZones[0].Id' --output text | cut -d'/' -f3)

cat > /tmp/dns-record.json << EOF
{
  "Changes": [{
    "Action": "UPSERT",
    "ResourceRecordSet": {
      "Name": "kubevpro.basquiat.app",
      "Type": "CNAME",
      "TTL": 300,
      "ResourceRecords": [{
        "Value": "$LB_URL"
      }]
    }
  }]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch file:///tmp/dns-record.json

echo "✅ Deployment completed!"
echo "🌐 Your application will be available at: http://kubevpro.basquiat.app"
echo "⏳ DNS propagation may take a few minutes"