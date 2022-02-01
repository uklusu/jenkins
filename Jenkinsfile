#!groovy
pipeline {
    agent any
    stages {
        stage('Build_server') {
            steps {
              withAWS(credentials: 'aws_main', region: 'us-east-2')
                sh ''' #!/bin/bash
                   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
                   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                   sudo apt-get update && sudo apt-get install terraform
                   terraform init
                   terraform apply -auto-approve
                   terraform output -raw  webserver_public_ip_adress > ip
                '''
                echo "hello world"

            }
        }
        stage('Test') {
            steps {
               echo "hello world"
            }
        }
        stage('Deploy') {
            steps {
                echo "hello world"
            }
        }
    }
}
