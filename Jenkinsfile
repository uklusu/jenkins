#!groovy
pipeline {
    agent any
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
               ip_ad=cat "ip"
               sudo chmod 777 shop.sh
               sudo chmod 777 drop
               sudo chmod 777 php
               sudo chmod 777 defailt
               echo $ip_ad
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
