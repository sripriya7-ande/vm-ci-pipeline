pipeline {
  agent any
  stages {
    stage('Terraform Apply') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          sh '''
            cd terraform
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
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
        ANSIBLE_PRIVATE_KEY=$SSH_AUTH_SOCK
        ansible-playbook -i ../inventory/inventory.ini playbook.yml
      '''
    }
  }
}

