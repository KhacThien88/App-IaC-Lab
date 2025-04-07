#!/bin/bash
apt-get update -y
apt-get install -y curl jq awscli git

cd /home/ubuntu
git clone https://github.com/KhacThien88/CloudHCMUS_Lab01_BE app
cd app

PARAM_JSON=$(aws ssm get-parameter --name "/credential-login" --with-decryption --query "Parameter.Value" --output text)

echo "$PARAM_JSON" | jq -r 'to_entries[] | "\(.key)=\(.value)"' > /home/ubuntu/app/.env
chown ubuntu:ubuntu /home/ubuntu/app/.env
chmod 600 /home/ubuntu/app/.env

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

npm install -g pm2
npm install
pm2 start server.js --name "my-node-app"
pm2 startup systemd -u ubuntu --hp /home/ubuntu
pm2 save
