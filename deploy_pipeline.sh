#!/bin/bash
set -e

echo "[CI/CD] Starting Local AWS Pipeline Execution..."

#Point AWS CLI to our local Floci Emulator using dummy credentials
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
export AWS_ENDPOINT_URL=http://localhost:4566

echo "[CI/CD] Provisioning emulated AWS EC2 instance via Floci..."
aws ec2 run-instances --image-id ami-ubuntu --instance-type t2.micro > /dev/null

echo "[CI/CD] Locating active EC2 runtime container..."
sleep 2
EC2_CONTAINER_ID=$(docker ps --latest --filter "ancestor=ubuntu" --format "{{.ID}}")

echo "[CI/CD] Target EC2 Container found: $EC2_CONTAINER_ID"

#Simulate deployment artifact transfer
echo "[CI/CD] Copying codebase artifacts to EC2 instance..."
docker cp app.py "$EC2_CONTAINER_ID":/root/app.py
docker cp requirements.txt "$EC2_CONTAINER_ID":/root/requirements.txt

#Simulate automated production server configurations
echo "[CI/CD] Executing remote configuration and booting web server..."
docker exec -d "$EC2_CONTAINER_ID" /bin/bash -c "apt-get update && apt-get install -y python3-pip && pip3 install -r /root/requirements.txt --break-system-packages && python3 /root/app.py"

echo "[CI/CD] Pipeline Finished! Deployment successful."
