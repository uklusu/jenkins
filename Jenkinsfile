#!groovy
pipeline {
    agent any
    stages {
        stage('Build_server') {
            steps {
                sh ''' #!/bin/bash
                   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - 
                   sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
                   sudo apt-get update && sudo apt-get install terraform -y
                   terraform init
                   terraform apply
                   terraform output | tr -d webserver_public_ip_adress|tr -d \" | tr -d = > ip
                '''

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
