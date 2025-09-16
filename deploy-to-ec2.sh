#!/bin/bash

# EC2 details
EC2_USER="ubuntu"
EC2_HOST="ec2-3-22-77-242.us-east-2.compute.amazonaws.com"
KEY_PATH="~/Downloads/docker-key.pem"

# Set correct permissions for the key
chmod 400 "$KEY_PATH"

# Transfer entire blog directory to EC2
scp -i "$KEY_PATH" -r ../blog $EC2_USER@$EC2_HOST:~/

echo "Blog directory copied to EC2 successfully!"