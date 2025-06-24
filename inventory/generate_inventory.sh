#!/bin/bash

# Get outputs from Terraform
cd terraform || exit 1
frontend_ip=$(terraform output -raw frontend_ip)
backend_ip=$(terraform output -raw backend_ip)

# Go to inventory directory to write inventory.ini
cd ../inventory || exit 1

# Create inventory.ini
cat > inventory.ini <<EOF
[frontend]
c8 ansible_host=${frontend_ip} ansible_user=ec2-user ansible_ssh_private_key_file=\${ANSIBLE_PRIVATE_KEY:-~/.ssh/New.pem}

[backend]
u21 ansible_host=${backend_ip} ansible_user=ubuntu ansible_ssh_private_key_file=\${ANSIBLE_PRIVATE_KEY:-~/.ssh/New.pem}
EOF

