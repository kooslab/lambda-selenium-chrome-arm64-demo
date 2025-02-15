#!/bin/bash

# Configuration
AWS_REGION="ap-northeast-2"  # Change this to your AWS region
ECR_REPO_NAME="test/demo-chromedriver-selenium-arm64"  # Change this to your ECR repository name
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REPO_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME"

# Login to ECR
echo "Logging into ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Create ECR repository if it doesn't exist
echo "Creating ECR repository if it doesn't exist..."
aws ecr describe-repositories --repository-names $ECR_REPO_NAME --region $AWS_REGION || \
aws ecr create-repository --repository-name $ECR_REPO_NAME --region $AWS_REGION

# Build the Docker image
echo "Building Docker image..."
docker build --platform linux/arm64 -t $ECR_REPO_NAME .

# Tag the image
# Create timestamp for consistent tagging
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Tagging image..."
docker tag $ECR_REPO_NAME:latest $ECR_REPO_URI:$TIMESTAMP

# Push the image to ECR
echo "Pushing image to ECR..."
docker push $ECR_REPO_URI:$TIMESTAMP

echo "Done! Your image is now available at: $ECR_REPO_URI:$TIMESTAMP"