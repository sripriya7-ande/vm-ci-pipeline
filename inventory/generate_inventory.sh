#!/bin/bash

# Get Terraform outputs directly from terraform folder
FRONTEND_IP=$(terraform -chdir=terraform output -raw frontend_ip)
BACKEND_IP=$(terraform -chdir=terraform output -raw backend_ip)

# Generate inventory.ini file
cat <<EOF > inventory/inventory.ini
[frontend]
c8 ansible_host=$FRONTEND_IP ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/New.pem

[backend]
u21 ansible_host=$BACKEND_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/New.pem
EOF

