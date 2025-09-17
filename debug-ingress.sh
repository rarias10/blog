#!/bin/bash

echo "🔍 Debugging Ingress Issues"
echo "=========================="

echo "📡 Ingress Status:"
kubectl get ingress -n blog-app -o wide

echo -e "\n🚀 Pod Status:"
kubectl get pods -n blog-app

echo -e "\n🌐 Service Status:"
kubectl get svc -n blog-app

echo -e "\n📋 Ingress Details:"
kubectl describe ingress ingress-srv -n blog-app

echo -e "\n🔧 NGINX Controller Logs (last 20 lines):"
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller --tail=20