#!/bin/bash

# Login to Docker Hub (you'll be prompted for credentials)
docker login

# Push all images to Docker Hub
docker push rarias1082/blog-posts:latest
docker push rarias1082/blog-comments:latest
docker push rarias1082/blog-query:latest
docker push rarias1082/blog-moderation:latest
docker push rarias1082/blog-event-bus:latest
docker push rarias1082/blog-client:latest

echo "All images pushed to Docker Hub successfully!"