#!groovy
pipeline {
    agent any

    stages {
        stage('Build_server') {
            steps {
              withAWS(credentials: 'aws_main', region: 'us-east-2'){
                sh ''' #!/bin/bash
                   sudo su
                   curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo  apt-key add -
                   sudo  apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                   sudo  apt-get update && sudo apt-get install terraform
                   terraform init

                   terraform apply -auto-approve
                   terraform output -raw  webserver_public_ip_adress > ip

                '''
                echo "hello world"
              }
            }
        }
        stage('Test') {
          environment {
            IP_ADD =  sh(returnStdout: true, script: "cat ip")
          }
            steps {
              sh ''' #!/bin

               sudo chmod 777 shop.sh
               sudo chmod 777 drop
               sudo chmod 777 php
               sudo chmod 777 default
               sleep 2m

               sleep 10
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD mkdir /home/ubuntu/docker
              scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/drop ubuntu@$IP_ADD:/home/ubuntu/docker/
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/php ubuntu@$IP_ADD:/home/ubuntu/docker/
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/default ubuntu@$IP_ADD:/home/ubuntu/docker/
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/shop.sh ubuntu@$IP_ADD:/home/ubuntu/docker/
               scp -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa $PWD/Dockerfile ubuntu@$IP_ADD:/home/ubuntu/docker/
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker build /home/ubuntu/docker/ -t test
               ssh -o StrictHostKeyChecking=no -i /home/ubuntu/id_rsa  ubuntu@$IP_ADD sudo docker run -d -p 80:80 test
               '''

          }
        }
        stage('Deploy') {
            steps {
              sh ''' #!/bin/bash
               cat  ip
              '''

            }
        }
    }
}
