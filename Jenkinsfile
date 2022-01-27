#!groovy
pipeline {
    agent any
    stages {
        stage('Build_server') {
            steps {
                bash ```
                   #!/bin/bash
                   terraform init
                   terraform apply
                   terraform output | tr -d webserver_public_ip_adress|tr -d \" | tr -d = > ip
                ```
              
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
