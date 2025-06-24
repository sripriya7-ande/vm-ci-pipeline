#!/bin/bash
terraform output -raw frontend_ip > frontend_ip.txt
terraform output -raw backend_ip > backend_ip.txt

FRONTEND_IP=$(cat frontend_ip.txt)
BACKEND_IP=$(cat backend_ip.txt)

cat > inventory.ini <<EOF
[frontend]
c8.local ansible_host=$FRONTEND_IP ansible_user=ec2-user

[backend]
u21.local ansible_host=$BACKEND_IP ansible_user=ubuntu
EOF
