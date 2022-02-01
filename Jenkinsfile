#!groovy
pipeline {
    agent any
    environment {
      aws_key= credentials('aws_ssh')
    }
    stages {
        stage('Build_server') {
            steps {
              withAWS(credentials: 'aws_main', region: 'us-east-2'){
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
        }
        stage('Test') {
            steps {          
              sh ''' #!/bin

               sudo chmod 777 shop.sh
               sudo chmod 777 drop
               sudo chmod 777 php
               sudo chmod 777 default
               ip_add= cat ip ; echo $ip_ad ;  scp -i $aws_ssh drop ubuntu@$ip_add:/home/ubuntu/drop

               '''

          }
        }
        stage('Deploy') {
            steps {
                echo "hello world"
            }
        }
    }
}
