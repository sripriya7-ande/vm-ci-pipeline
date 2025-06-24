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

    stage('Ansible Provisioning') {
  steps {
    sshagent(['aws-ssh']) {
      sh '''
        cd ansible
        ansible-playbook -i ../inventory/inventory.ini playbook.yml
      '''
    }
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
