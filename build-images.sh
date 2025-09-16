#!/bin/bash

# Build all Docker images
docker build -t blog-posts ./posts
docker build -t blog-comments ./comments
docker build -t blog-query ./query
docker build -t blog-moderation ./moderation
docker build -t blog-event-bus ./event-bus
docker build -t blog-client ./client

echo "All images built successfully!"
docker images | grep blog-