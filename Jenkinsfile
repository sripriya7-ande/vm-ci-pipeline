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
          ./generate_inventory.sh
        '''
      }
    }

    stage('Run Ansible Playbook') {   // ✅ Renamed to avoid duplication
      steps {
        sshagent(['aws-ssh']) {
          sh '''
            cd ansible
            ansible-playbook -i ../inventory/inventory.ini playbook.yml
          '''
        }
      }
    }
  }
}
