pipeline {
  agent any

  environment {
    ANSIBLE_PRIVATE_KEY = credentials('ec2-user')
  }

  stages {
    stage('Terraform Apply') {
      steps {
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'your-aws-credentials-id']]) {
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
        sshagent(['ec2-user']) {
          sh '''
            cd ansible
            ansible-playbook -i ../inventory/inventory.ini playbook.yml
          '''
        }
      }
    }
  }
}
