#!/bin/bash

echo "🔄 Rebuilding and redeploying all services..."

# Build and push updated images
docker build -t rarias1082/blog-posts:latest ./posts
docker build -t rarias1082/blog-query:latest ./query

docker push rarias1082/blog-posts:latest
docker push rarias1082/blog-query:latest

# Apply ingress changes
kubectl apply -f infra/k8s/ingress-srv.yaml

# Restart deployments to pull new images
kubectl rollout restart deployment posts-depl -n blog-app
kubectl rollout restart deployment query-depl -n blog-app

echo "✅ Redeployment complete!"