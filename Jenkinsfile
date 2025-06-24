pipeline {
  agent any

  stages {
    stage('Terraform Apply') {
      steps {
        sh '''
          cd terraform
          terraform init
          terraform apply -auto-approve
        '''
      }
    }

    stage('Generate Ansible Inventory') {
      steps {
        sh '''
          cd inventory
          ../terraform/terraform output -raw frontend_ip > frontend_ip.txt
          ../terraform/terraform output -raw backend_ip > backend_ip.txt
          ./generate_inventory.sh
        '''
      }
    }

    stage('Ansible Provisioning') {
      steps {
        sh '''
          cd ansible
          ansible-playbook -i ../inventory/inventory.ini playbook.yml
        '''
      }
    }
  }
}
