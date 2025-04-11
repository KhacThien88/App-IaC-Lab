#!/bin/bash

# Update packages
sudo apt update -y
sudo apt install -y ruby-full awscli

# Set region variable
REGION=ap-southeast-1

# Stop and remove CodeDeploy agent if it exists
CODEDEPLOY_BIN="/opt/codedeploy-agent/bin/codedeploy-agent"
if [ -f "$CODEDEPLOY_BIN" ]; then
    sudo $CODEDEPLOY_BIN stop
fi
sudo apt remove -y codedeploy-agent

# Download and install CodeDeploy agent
aws s3 cp s3://aws-codedeploy-$REGION/latest/install . --region $REGION
chmod +x ./install
sudo ./install auto


# Clean up
rm -f ./install
