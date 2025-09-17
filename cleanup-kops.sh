#!/bin/bash

# Cleanup Kops Cluster
set -e

echo "🗑️ Cleaning up Kops cluster..."

# Delete the cluster
kops delete cluster --name kubevpro.basquiat.app --state=s3://kopsstate1357 --yes

echo "✅ Cluster deleted successfully!"