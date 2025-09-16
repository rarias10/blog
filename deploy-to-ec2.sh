#!/bin/bash

# Replace with your EC2 details
EC2_USER="ec2-user"
EC2_HOST="your-ec2-public-ip"
KEY_PATH="path/to/your-key.pem"

# Transfer code to EC2
scp -i $KEY_PATH -r . $EC2_USER@$EC2_HOST:~/blog/

# Connect to EC2 and build images
ssh -i $KEY_PATH $EC2_USER@$EC2_HOST << 'EOF'
cd ~/blog
chmod +x build-images.sh
./build-images.sh
EOF