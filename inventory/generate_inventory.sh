#!/bin/bash

cd terraform
frontend_ip=$(terraform output -raw frontend_ip)
backend_ip=$(terraform output -raw backend_ip)
cd - > /dev/null

cat > inventory/inventory.ini <<EOF
[frontend]
c8 ansible_host=${frontend_ip} ansible_user=ec2-user

[backend]
u21 ansible_host=${backend_ip} ansible_user=ubuntu
EOF
