#!/bin/bash

# Update packages
sudo yum update -y

# Install ruby and awscli
sudo yum install -y ruby awscli

# Set region variable
REGION=ap-southeast-1

# Stop and remove CodeDeploy agent if it exists
CODEDEPLOY_BIN="/opt/codedeploy-agent/bin/codedeploy-agent"
if [ -f "$CODEDEPLOY_BIN" ]; then
    sudo $CODEDEPLOY_BIN stop
    sudo yum remove -y codedeploy-agent
fi

# Download and install CodeDeploy agent
aws s3 cp s3://aws-codedeploy-$REGION/latest/install . --region $REGION
chmod +x ./install
sudo ./install auto

# Start and enable agent
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent

# Optional: check status
sudo systemctl status codedeploy-agent

# Wait to ensure agent is fully up
sleep 20

# Clean up
rm -f ./install