pipeline {
  agent any

  stages {
    stage('Terraform Apply') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds'
        ]]) {
          sh '''
            cd terraform
            terraform init
            terraform apply -auto-approve
          '''
        }
      }
    }

    stage('Generate Ansible Inventory') {
      steps {
        sh '''
          chmod +x inventory/generate_inventory.sh
          ./inventory/generate_inventory.sh
        '''
      }
    }

    stage('Run Ansible Playbook') {
      steps {
        sshagent(credentials: ['ec2-ssh-key']) {
          sh '''
            cd ansible
            ansible-playbook -i ../inventory/inventory.ini playbook.yml
          '''
        }
      }
    }
  }
}
