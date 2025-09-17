#!/bin/bash

# Check Blog Application Status
echo "📊 Blog Application Status"
echo "=========================="

echo "🔍 Cluster Status:"
kops validate cluster --name kubevpro.basquiat.app --state=s3://kopsstate1357

echo -e "\n🚀 Application Pods:"
kubectl get pods -n blog-app

echo -e "\n🌐 Services:"
kubectl get svc -n blog-app

echo -e "\n🔗 Ingress:"
kubectl get ingress -n blog-app

echo -e "\n📡 LoadBalancer URL:"
kubectl get svc -n ingress-nginx | grep LoadBalancer