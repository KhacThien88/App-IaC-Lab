#!/bin/bash
set -euo pipefail  # Fail on errors and undefined variables

# Update and install packages
sudo apt-get update -y
sudo apt-get install -y curl jq awscli git mysql-client

sudo systemctl start mysql
sudo systemctl enable mysql

# Install Node.js (more secure method)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Clone application
cd /home/ubuntu
sudo -u ubuntu git clone https://github.com/KhacThien88/CloudHCMUS_Lab01_BE app
cd app

# Get database credentials securely
PARAM_JSON=$(sudo -u ubuntu aws ssm get-parameter --name "credential-login" --with-decryption --query "Parameter.Value" --output text)

# Create .env file with proper permissions
sudo -u ubuntu bash -c "echo \"$PARAM_JSON\" | jq -r 'to_entries[] | \"\(.key)=\(.value)\"' > /home/ubuntu/app/.env"
sudo chown ubuntu:ubuntu /home/ubuntu/app/.env
sudo chmod 600 /home/ubuntu/app/.env

SECRET_NAME="mysqldb_lab01_hcmus_v1"
SECRET_JSON=$(aws secretsmanager get-secret-value --name "$SECRET_NAME" --query SecretString --output text)
RDS_ENDPOINT=$(echo "$SECRET_JSON" | jq -r '.host')
RDS_USERNAME=$(echo "$SECRET_JSON" | jq -r '.username')
RDS_PASSWORD=$(echo "$SECRET_JSON" | jq -r '.password')
RDS_PORT=$(echo "$SECRET_JSON" | jq -r '.port')
RDS_DB_NAME=$(echo "$SECRET_JSON" | jq -r '.db_name')
echo "Initializing RDS database..."
mysql -h "$RDS_ENDPOINT" -u "$RDS_USERNAME" -p"$RDS_PASSWORD" -P "$RDS_PORT" < /home/ubuntu/app/ASG/aws_launch_template/init_db.sql

# Install application dependencies
sudo -u ubuntu npm install
sudo -u ubuntu npm install -g pm2

# Start application
sudo -u ubuntu pm2 start server.js --name "my-node-app"
sudo -u ubuntu pm2 startup systemd -u ubuntu --hp /home/ubuntu
sudo -u ubuntu pm2 save
