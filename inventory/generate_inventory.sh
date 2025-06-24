#!/bin/bash

cd terraform
frontend_ip=$(terraform output -raw frontend_ip)
backend_ip=$(terraform output -raw backend_ip)
cd - > /dev/null

PRIVATE_KEY_PATH="/var/lib/jenkins/.ssh/New.pem"

cat > inventory/inventory.ini <<EOF
[frontend]
c8 ansible_host=${frontend_ip} ansible_user=ec2-user ansible_ssh_private_key_file=${PRIVATE_KEY_PATH}

[backend]
u21 ansible_host=${backend_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${PRIVATE_KEY_PATH}
EOF
